From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Apr 2016 14:10:46 -0700
Subject: [PATCH v2 1/2] ARM: dts: am335x: Add initial support for ICEv2
 board
In-Reply-To: <56F265EC.5050208@ti.com>
References: <1458704054-18152-1-git-send-email-lokeshvutla@ti.com>
 <1458704054-18152-2-git-send-email-lokeshvutla@ti.com>
 <56F265EC.5050208@ti.com>
Message-ID: <20160412211045.GD5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160323 02:47]:
> On 03/23/2016 05:34 AM, Lokesh Vutla wrote:
> >TI's Industrial Communication Engine EVM is a low cost hardware mainly
> >developed for industrial communication type applications using serial
> >or Ethernet based interfaces. This platform features TI's AM3359 with
> >800MHz single core Cortex-A8 processor, 256MB DDR3, 64MB SPI flash,
> >8MB NOR Flash, mmc, usb, can, dual Ethernet ports.
> >
> >For more information, look at HW user guide[1], Data manual[2].
> >
> >Just add basic support for the moment.
> >
> >[1] http://processors.wiki.ti.com/index.php/AM335x_Industrial_Communication_Engine_EVM_Rev2_1_HW_User_Guide
> >[2] http://www.ti.com/lit/ds/symlink/am3359.pdf
> >
> >Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applying this patch into omap-for-v4.7/dt thanks.

Tony
