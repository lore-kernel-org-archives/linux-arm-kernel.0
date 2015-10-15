From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 17:20:38 +0200
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <20151015115825.GO3394@e106497-lin.cambridge.arm.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <20151015115825.GO3394@e106497-lin.cambridge.arm.com>
Message-ID: <6996407.poki4ZurkV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 12:58:25 Liviu Dudau wrote:
> On Thu, Oct 15, 2015 at 12:20:15PM +0200, Linus Walleij wrote:
> > The Juno motherboard has a NOR flash on the motherboard, enable
> > this to be accessed with the CFI flash driver. Results after
> > enabling MTD, MTD_CFI, MTD_PHYSMAP, MTD_PHYSMAP_OF,
> > MTD_CFI_INTELEXT:
> > 
> > 8000000.flash: Found 2 x16 devices at 0x0 in 32-bit bank.
> > Manufacturer ID 0x000089 Chip ID 0x008919
> > Intel/Sharp Extended Query Table at 0x010A
> > Intel/Sharp Extended Query Table at 0x010A
> > Intel/Sharp Extended Query Table at 0x010A
> > Intel/Sharp Extended Query Table at 0x010A
> > Intel/Sharp Extended Query Table at 0x010A
> > Using buffer write method
> > Using auto-unlock on power-up/resume
> > cfi_cmdset_0001: Erase suspend on write enabled
> > erase region 0: offset=0x0,size=0x40000,blocks=255
> > erase region 1: offset=0x3fc0000,size=0x10000,blocks=4
> > 
> > Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Applied to next/dt, thanks!

	Arnd
