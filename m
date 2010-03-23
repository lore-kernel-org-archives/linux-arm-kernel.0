From: nm@ti.com (Nishanth Menon)
Date: Tue, 23 Mar 2010 17:49:08 -0500
Subject: mmc errors (was Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3)
In-Reply-To: <20100323152709.GD11448@atomide.com>
References: <20100322212025.GW11448@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F127117@dbde02.ent.ti.com>
	<20100323152709.GD11448@atomide.com>
Message-ID: <4BA94564.8030803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren had written, on 03/23/2010 10:27 AM, the following:
[...]
> Then at least one issue remains for zoom3 to be usable..
> I'm getting tons of MMC errors trying to mount root on it:
> 
> mmcblk1: error -110 transferring data, sector 2097024, nr 8, card status 0x900  
> end_request: I/O error, dev mmcblk1, sector 2097024
> ...
> 
I have seen this on few platforms and seem to be related to eMMC usage.

> Any ideas if that's fixed somewhere also?
Madhu, any comments?

-- 
Regards,
Nishanth Menon
