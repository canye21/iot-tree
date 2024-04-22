package org.iottree.core.router.roa;

import java.util.List;

import org.iottree.core.router.JoinIn;
import org.iottree.core.router.JoinOut;
import org.iottree.core.router.RouterManager;
import org.iottree.core.router.RouterOuterAdp;

public class ROAMqtt extends RouterOuterAdp
{

	public ROAMqtt(RouterManager rm)
	{
		super(rm);
	}

	@Override
	public String getTp()
	{
		return "mqtt";
	}

	@Override
	public RouterOuterAdp newInstance(RouterManager rm)
	{
		return new ROAMqtt(rm);
	}

	@Override
	protected void RT_onRecvedFromJoinIn(JoinIn ji, Object recved_txt) throws Exception
	{
		
	}

	@Override
	public List<JoinIn> getJoinInList()
	{
		return null;
	}

	@Override
	public List<JoinOut> getJoinOutList()
	{
		return null;
	}

	@Override
	public void RT_start()
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	public void RT_stop()
	{
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean RT_isRunning()
	{
		// TODO Auto-generated method stub
		return false;
	}

}