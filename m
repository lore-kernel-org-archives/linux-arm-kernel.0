From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Jun 2011 15:15:18 -0700
Subject: [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is...
	from driver
In-Reply-To: <1309212726.6231.14.camel@vence>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
	<20110615213637.GH15795@trinity.fluff.org>  <87k4cm1xgj.fsf@ti.com>
	<1309212726.6231.14.camel@vence>
Message-ID: <1309212918.6231.16.camel@vence>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-06-27 at 15:12 -0700, Kevin Hilman wrote:

> Ping.  I don't see this in linux-next yet.
> 
> Are you planning to queue this for v3.1?
> 

Oops, pushed send too soon on this...

As this series touches various data files in arch/arm/mach-omap2/* and
we have a handful of other changes to that data for this merge window, I
think it would be better for conflict avoidance if this series is merged
via Tony's linux-omap tree.

With your Ack, we'll merge it via OMAP.

Thanks,

Kevin
