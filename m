From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Jul 2014 00:25:45 -0700
Subject: [PATCH] ARM: omap2+: gpmc-nand: Use dynamic
 platform_device_alloc()
In-Reply-To: <53BFEA6A.4020501@ti.com>
References: <1401891875-27843-1-git-send-email-lisovy@merica.cz>
 <53BFEA6A.4020501@ti.com>
Message-ID: <20140715072544.GA28715@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [140711 06:47]:
> On 06/04/2014 05:24 PM, Rostislav Lisovy wrote:
> > GPMC controller supports up to 8 memory devices connected to it.
> > Since there is one statically allocated "struct platform_device
> > gpmc_nand_device" it is not possible to configure the system to
> > use more than one NAND device connected to the GPMC. This
> > modification makes it possible to use up to 8 NAND devices
> > connected to the GPMC controller.
> > 
> > Signed-off-by: Rostislav Lisovy <lisovy@merica.cz>
> 
> pushed to git at github.com:rogerq/linux.git	for-v3.17/gpmc-omap
> 
> Tony,
> 
> You can please pull all omap-gpmc patches for 3.17 from there. Thanks.

OK so just this one fix, merging into omap-for-v3.17/fixes-not-urgent.

Regards,

Tony
