From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Apr 2012 14:54:08 +0000
Subject: Defconfig update for LPC32xx
In-Reply-To: <4F904795.4050505@antcom.de>
References: <4F904795.4050505@antcom.de>
Message-ID: <201204201454.09200.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 April 2012, Roland Stigge wrote:
> Hi,
> 
> I'm planning to update arch/arm/configs/lpc32xx_defconfig, adjusting to
> device tree and new driver options.
> 
> Now I wonder if I should (1) just add drivers which are used on the
> reference machine (PHYTEC LPC3250 board) or (2) additionally add all
> drivers that I have seen together with LPC32xx on other boards also,
> which would demonstrate that the same binary kernel runs on all LPC32xx
> machines, but increasing kernel size a bit.
> 
> I would prefer option (2) but first want to ask for advice.

I think either way is fine, this is one of the things I would completely
leave to you as the platform maintainer.

If you know that other machines are working with the same defconfig,
it would be helpful to also have their .dts files in the kernel source
for reference, but not mandatory.

	Arnd
