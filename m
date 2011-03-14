From: andy@warmcat.com (Andy Green)
Date: Mon, 14 Mar 2011 17:57:27 +0000
Subject: [PATCH 2 00/18] I2C: OMAP: Fixes and removal of cpu_... from
	driver
In-Reply-To: <20110314174209.GC7258@atomide.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
	<4D76A164.2060801@ti.com> <20110308233820.GJ26463@atomide.com>
	<4D778873.4070308@ti.com> <20110309191115.GM26463@atomide.com>
	<20110314174209.GC7258@atomide.com>
Message-ID: <4D7E5707.5030305@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2011 05:42 PM, Somebody in the thread at some point said:

Hi -

> It looks like this series can be rebased on v2.6.38-rc8
> and should merge just fine with what we have queued in
> omap-for-linus. I guess I forgot we already did the i2c-omap
> hwmod conversion last merge window :)
>
> Andy, please repost the related patches against v2.6.38-rc8 with
> the acks posted earlier.

Alright, I will do that with the reordered patch from Benoit and the 
change to BIT() instead of constants.  Thanks.

-Andy
