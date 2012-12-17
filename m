From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 17 Dec 2012 11:52:41 -0600
Subject: [PATCH V2 0/2] ARM: dts: Add PMU support for OMAP2+
In-Reply-To: <1355766548-5702-1-git-send-email-jon-hunter@ti.com>
References: <1355766548-5702-1-git-send-email-jon-hunter@ti.com>
Message-ID: <50CF5BE9.3020000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/17/2012 11:49 AM, Jon Hunter wrote:
> Add device-tree PMU support for OMAP2, OMAP3 and OMAP4460. OMAP4430
> is not included because PMU is not currently supported on this device
> due to absence of a cross-trigger interface driver.
> 
> Tested with PERF on OMAP3430 Beagle Board and OMAP4460 Panda Board.
> Boot tested only on OMAP2420 H4.

Forgot to mention that V2, addresses Mark Rutland's comment on interrupt
syntax for omap4460 PMU node. I also added a comment on why OMAP4430 is
not supported too.

Cheers
Jon
