From: michael@walle.cc (Michael Walle)
Date: Sun, 6 Nov 2011 23:40:58 +0100
Subject: orion/kirkwood and device tree
In-Reply-To: <20111106160538.GD19491@lunn.ch>
References: <20111031105740.GC29402@lunn.ch>
 <201110312350.28475.michael@walle.cc> <20111106160538.GD19491@lunn.ch>
Message-ID: <201111062340.59042.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

thanks for the patch,

Am Sonntag 06 November 2011, 17:05:38 schrieb Andrew Lunn:
> Soon to follow is my patch to cleanup the address mapping of orion
> based platforms. I think this is one step towards solving your
> kirkwood_mbus_dram_info problem. I think the next steps are:
> 
> Rename all the {kirkwood|dove|orion5x|mv78xx0}_mbus_dram_info to
> orion_mbus_dram_info and move this variable into
> arch/arm/plat-orion/addr-map.c.
> 
> Move all the address setup code which is currently in various drives
> into arch/arm/plat-orion/addr-map.c. Remove orion_mbus_dram_info from
> all the platform_data structures.
mh and then use orion_mbus_dram_info directly within the device drivers?

-- 
Michael
