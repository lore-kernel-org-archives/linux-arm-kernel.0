From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 9 Feb 2012 19:58:32 +0100
Subject: [PATCH 04/16] ARM: omap: fix prm44xx.c OMAP44XX_IRQ_PRCM build
 error
In-Reply-To: <20120208183951.GD29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAW4-0006Gy-S6@rmk-PC.arm.linux.org.uk>
 <20120208183951.GD29796@atomide.com>
Message-ID: <4F341758.6080400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 2/8/2012 7:39 PM, Tony Lindgren wrote:
> * Russell King - ARM Linux<linux@arm.linux.org.uk>  [120208 08:06]:
>> arch/arm/mach-omap2/prm44xx.c:41: error: 'OMAP44XX_IRQ_PRCM' undeclared here (not in a function)
> 
> Can you please add something like "This happens when CONFIG_OF is
> not selected".
> 
>> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> 
> Other than that:
> 
> Acked-by: Tony Lindgren<tony@atomide.com>

It looks like prm2xxx_3xxx.c does have the exact same issue than prm44xx.c.

arch/arm/mach-omap2/prm2xxx_3xxx.c:41:11: error: ?INT_34XX_PRCM_MPU_IRQ? undeclared here (not in a function)

Patch will follow.

Regards,
Benoit
