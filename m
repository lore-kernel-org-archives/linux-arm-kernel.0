From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Nov 2014 07:49:02 -0800
Subject: [PATCH 06/10] ARM: OMAP2+: Show bootloader GPMC timings to allow
 configuring the .dts file
In-Reply-To: <5458D731.1010208@ti.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
 <1414628948-30702-7-git-send-email-tony@atomide.com>
 <545248FA.7040201@ti.com> <20141030144529.GG2542@atomide.com>
 <54525362.9080000@ti.com> <20141030163031.GG2560@atomide.com>
 <5458D731.1010208@ti.com>
Message-ID: <20141104154902.GQ31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [141104 05:41]:
> 
> I don't have any board with smsc or working NOR so I called
> gpmc_cs_show_timings() after NAND was setup.
> 
> The printed values match closely to the configured values in the DTS.

OK thanks for checking. I've checked with smsc91x, smsc911x and
8250 so far so I think we're good to go.

Regards,

Tony
