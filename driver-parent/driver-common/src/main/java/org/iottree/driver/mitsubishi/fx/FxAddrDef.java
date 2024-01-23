package org.iottree.driver.mitsubishi.fx;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.iottree.core.UAVal;
import org.iottree.core.UAVal.ValTP;

public class FxAddrDef
{
	
	
	/**
	 * X Y M
	 */
	String prefix = null ;
	
	
	ArrayList<FxAddrSeg> segs = new ArrayList<>() ; 
		
	public FxAddrDef(String prefix)
	{
		this.prefix = prefix ;
		//this.title = title ;
	}
	
	public FxAddrDef asValTpSeg(FxAddrSeg seg)
	{
		seg.belongTo = this ;
		this.segs.add(seg) ;
		return this ;
	}
	
	public String getPrefix()
	{
		return this.prefix ;
	}
	
//	public String getTitle()
//	{
//		return this.title ;
//	}
	
	public List<FxAddrSeg> getSegs()
	{
		return this.segs ;
	}
	
	/**
	 * @param vtp
	 * @return
	 */
	public List<FxAddrSeg> findSegs(ValTP vtp)
	{
		ArrayList<FxAddrSeg> rets = new ArrayList<>() ;
		for(FxAddrSeg seg:this.segs)
		{
			if(seg.matchValTP(vtp))
			{
				rets.add(seg) ;
			}
		}
		return rets ;
	}
	
	public FxAddrSeg findSeg(ValTP vtp,String addr)
	{
		//ArrayList<FxAddrSeg> rets = new ArrayList<>() ;
		for(FxAddrSeg seg:this.segs)
		{
			if(seg.matchValTP(vtp))
			{
				if(seg.matchAddr(addr)!=null)
					return seg ;
			}
		}
		return null ;
	}
	
	public FxAddrSeg findSeg(FxAddr fxaddr)
	{
		ValTP vtp = fxaddr.getValTP() ;
		if(vtp==null)
			return null ;
		
		for(FxAddrSeg seg:this.segs)
		{
			if(seg.matchValTP(vtp))
			{
				if(seg.matchAddr(fxaddr))
					return seg ;
			}
		}
		return null ;
	}
	//public FxAddr trans
}
