From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Aug 2012 00:20:42 -0700
Subject: [PATCH v2] ARM: OMAP4: twl-common: Support for additional
 devices on i2c1 bus
In-Reply-To: <500D0FA5.3020208@ti.com>
References: <1342168682-15888-1-git-send-email-peter.ujfalusi@ti.com>
 <500D0FA5.3020208@ti.com>
Message-ID: <20120807072041.GL11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120723 01:52]:
> Hi Tony,
> 
> On 07/13/2012 10:38 AM, Peter Ujfalusi wrote:
> > On OMAP4 the i2c1 bus is dedicated for the PMIC and audio related devices.
> > Manufacturers can opt to use different codec than twl6040 and also can add
> > audio related IC to the bus (external amplifier for example on SDP4430).
> > 
> > Make it possible to add differnet set of additional devices to i2c1 bus on
> > OMAP4 boards.
> 
> Would it be possible to queue this patch for 3.6?

Sorry things were getting already too complex for v3.6 merge window..
So v3.7 it will be. Looks like this need to be updated against v3.6-rc1
to apply.

Regards,

Tony
