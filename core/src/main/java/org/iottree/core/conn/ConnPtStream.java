package org.iottree.core.conn;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.iottree.core.ConnException;
import org.iottree.core.ConnProvider;
import org.iottree.core.ConnPt;
import org.iottree.core.basic.IConnEndPoint;
import org.iottree.core.util.Convert;
import org.iottree.core.util.DesInputStream;
import org.iottree.core.util.DesOutputStream;

public abstract class ConnPtStream extends ConnPtBinder implements IConnEndPoint
{

	public static String TP = "stream" ;
	
	
	private MonInputStream monInputS = null ;
	
	private MonOutputStream monOutputS = null ;

	private DesInputStream inputEnc = null ;
	private DesOutputStream outputEnc = null ;
	
	private String encKey = null ;
	
	//private transient boolean 
	
	public ConnPtStream()
	{}
	
	public ConnPtStream(ConnProvider cp,String name,String title,String desc)
	{
		super(cp,name,title,desc);
	}
	
	
	public final InputStream getInputStream()// throws Exception
	{
		InputStream inputs = getInputStreamInnerEnc() ;
		if(inputs==null)
			return null ;
		if(monInputS == null)
		{
			monInputS = new MonInputStream(inputs) ;
			return monInputS ;
		}
		
		if(monInputS.getWrapperInputStream()==inputs)
			return monInputS ;
		
		monInputS.setWrapperInputStream(inputs);
		return monInputS ;
	}
	
	public final OutputStream getOutputStream()
	{
		OutputStream outputs = getOutputStreamInnerEnc() ;
		if(outputs==null)
			return null ;
		if(monOutputS == null)
		{
			monOutputS = new MonOutputStream(outputs) ;
			return monOutputS ;
		}
		
		if(monOutputS.getWrapperOutputStream()==outputs)
			return monOutputS ;
		
		monOutputS.setWrapperOutputStream(outputs);
		return monOutputS ;
	}
	
	

	public synchronized void setEncKey(String ekey) throws Exception
	{
		encKey = ekey ;
		inputEnc = null ;
		outputEnc = null ;
	}
	
	
	
	private synchronized InputStream getInputStreamInnerEnc()// throws Exception
	{
		InputStream ins =  getInputStreamInner() ;
		if(ins==null)
			return null ;
		if(encKey==null||encKey.contentEquals(""))
			return ins ;
		
		if(inputEnc==null||inputEnc.getInnerInputStream()!=ins)
		{
			byte[] kk = encKey.getBytes() ;
			try
			{
				inputEnc = new DesInputStream(kk,ins);
			}
			catch(Exception e)
			{
				e.printStackTrace();
				throw new RuntimeException(e.getMessage());
			}
		}
		return inputEnc ;
		
	}
	
	
	
	
	private synchronized OutputStream getOutputStreamInnerEnc() //throws Exception
	{
		OutputStream outs = getOutputStreamInner();
		if(outs==null)
			return null ;

		if(encKey==null||encKey.contentEquals(""))
			return outs ;
		
		if(outputEnc==null||outputEnc.getInnerOutputStream()!=outs)
		{
			byte[] kk = encKey.getBytes() ;
			try
			{
				outputEnc = new DesOutputStream(kk,outs);
			}
			catch(Exception e)
			{
				e.printStackTrace();
				throw new RuntimeException(e.getMessage());
			}
		}
		return outputEnc ;
	}
	
	protected abstract InputStream getInputStreamInner() ;
	
	protected abstract OutputStream getOutputStreamInner();
	
	
	
	public abstract boolean isClosed() ; 
	
	//public abstract String getConnST() ;
	
	
	public class MonInputStream extends InputStream
	{
		InputStream wrapperInputs = null ;
		
		MonInputStream(InputStream inputs)
		{
			wrapperInputs = inputs ;
		}
		
		public InputStream getWrapperInputStream()
		{
			return wrapperInputs ;
		}
		
		public void setWrapperInputStream(InputStream inputs)
		{
			this.wrapperInputs = inputs ;
		}
		

		@Override
		public int available() throws IOException
		{
			try
			{
				return wrapperInputs.available();
			}
			catch(Exception e)
			{
				ConnPtStream.this.fireConnInvalid();
				throw new ConnException(e) ; // it will be catched
			}
		}
		
		@Override
		public void close() throws IOException
		{
			try
			{
				wrapperInputs.close();
			}
			catch(Exception e)
			{
				ConnPtStream.this.fireConnInvalid();
				throw new ConnException(e) ; // it will be catched
			}
		}
		
		@Override
		public synchronized void mark(int readlimit)
		{
			wrapperInputs.mark(readlimit);
		}
		
		@Override
		public boolean markSupported()
		{
			return wrapperInputs.markSupported();
		}
		
		@Override
		public int read() throws IOException
		{
			int v ;
			try
			{
				v = wrapperInputs.read();
			}
			catch(Exception e)
			{
				ConnPtStream.this.fireConnInvalid();
				throw new ConnException(e) ; // it will be catched
			}
			//onMonRecv(true,v) ;
			byte[] bs = new byte[1] ;
			bs[0] = (byte)v ;
			onMonDataRecv(true,bs);
			return v ;
		}
		
		
//		
//		@Override
//		public int read(byte[] b) throws IOException
//		{
//			//return wrapperInputs.read(b);
//			super.read(b) ;
//		}
//		
		@Override
		public int read(byte[] b, int off, int len) throws IOException
		{
			int r ;
			try
			{
				r = wrapperInputs.read(b, off, len);
			}
			catch(Exception e)
			{
				ConnPtStream.this.fireConnInvalid();
				throw new ConnException(e) ; // it will be catched
			}
			
			if(r<=0)
				return r ;
			byte[] bs = new byte[r] ;
			System.arraycopy(b, off, bs, 0, r);
			onMonDataRecv(true,bs);
			return r ;
		}
		
		@Override
		public synchronized void reset() throws IOException
		{
			try
			{
				wrapperInputs.reset();
			}
			catch(Exception e)
			{
				ConnPtStream.this.fireConnInvalid();
				throw new ConnException(e) ; // it will be catched
			}
		}
		
		@Override
		public long skip(long n) throws IOException
		{
			try
			{
				return wrapperInputs.skip(n);
			}
			catch(Exception e)
			{
				ConnPtStream.this.fireConnInvalid();
				throw new ConnException(e) ; // it will be catched
			}
		}
	}
	
	public class MonOutputStream extends OutputStream
	{
		OutputStream wrapperOutputs = null ;
		
		MonOutputStream(OutputStream outputs)
		{
			wrapperOutputs = outputs ;
		}
		
		public OutputStream getWrapperOutputStream()
		{
			return wrapperOutputs ;
		}
		
		public void setWrapperOutputStream(OutputStream outputs)
		{
			this.wrapperOutputs = outputs ;
		}
		
		@Override
		public void write(int b) throws IOException
		{
			try
			{
				wrapperOutputs.write(b);
			}
			catch(Exception e)
			{
				ConnPtStream.this.fireConnInvalid();
				throw new ConnException(e) ; // it will be catched
			}
			byte[] bs = new byte[1] ;
			bs[0] = (byte)b ;
			onMonDataRecv(false,bs) ;
		}
		
		
		@Override
		public void write(byte[] b, int off, int len) throws IOException
		{
			try
			{
				//super.write - 会引起严重问题，底层数据包可能会被拆分
				wrapperOutputs.write(b, off, len);
			}
			catch(Exception e)
			{
				ConnPtStream.this.fireConnInvalid();
				throw new ConnException(e) ; // it will be catched
			}
			byte[] bs = new byte[len] ;
			System.arraycopy(b, off, bs, 0, len);
			onMonDataRecv(false,bs) ;
		}
		
		@Override
		public void close() throws IOException
		{
			try
			{
				wrapperOutputs.close();
			}
			catch(Exception e)
			{
				ConnPtStream.this.fireConnInvalid();
				throw new ConnException(e) ; // it will be catched
			}
		}
		
		@Override
		public void flush() throws IOException
		{
			try
			{
				wrapperOutputs.flush();
			}
			catch(Exception e)
			{
				ConnPtStream.this.fireConnInvalid();
				throw new ConnException(e) ; // it will be catched
			}
		}
	}
}
