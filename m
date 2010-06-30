From: rajkumar278@hotmail.com (Raj Kumar)
Date: Wed, 30 Jun 2010 16:52:01 +0530
Subject: Run time power management in linux kernel from 2.6.32
Message-ID: <BLU102-W152BFD91AB0F2CE91B71FEBCC0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi,
 
I am working in power management. I have few questions about run time power management
 
which was merged in linux 2.6.32 kernel onwards. Since the run time power management 
 
defines that when idle, suspend and resume will be scheduled, now the thing is from
 
device driver perspective, it is bus driver that will suspend and resume its devices.
 
but what from driver perspective driver needs to implement means as run time power
 
management has also helper functions which will tell PM core that when to call various
 
callbacks for suspend and resume for drivers (device, bus). 
 
But it might be case when the whole bus is not idle and still some drivers can be put
 
into low power mode. Then does bus driver will be responsible for invoking the driver's
 
suspend and resume (run time) or PM core will do that ?
 
Use cases:
------------
 
1) When the bus is idle
2) When the bus is not idle but still some peripherals can be put into low power mode......
 
 
 
 
 
Regards
Raj 		 	   		  
