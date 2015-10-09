From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 17:22:29 +0200
Subject: [GIT PULL] Broadcom devicetree changes for v4.4
In-Reply-To: <1443824458-20799-2-git-send-email-f.fainelli@gmail.com>
References: <1443824458-20799-1-git-send-email-f.fainelli@gmail.com>
 <1443824458-20799-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <40550670.urifmOa4Gl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 October 2015 15:20:56 Florian Fainelli wrote:
> This pull requests contains the following Broadcom SoCs Device Tree changes:
> 
> - Brian Norris documents the BCM7445 SoCs Power Management controllers and
>   hardware and updates the reference BCM7445 Device Tree with these nodes
> 
> - Florian Fainelli documents the BCM7xxx write-pairing feature in the top-level
>   BCM7xxx binding document
> 
> - Hauke Merthens enables the NAND controller for the Asus RT-AC87U and adds the
>   GPIO pin controlling the USB power supply on Netgear R6250
> 
> - Jon Mason adds support for the NorthStar Plus SoC by providing a top-level
>   binding document and the minimalist device tree skeleton for these SoCs
> 
> - Rafal Milecki adds support for the Netgear R7000 (BCM5301x SoC)
> 
> - Ray Jui provides a set of Cygnus DT changes that make the Device Tree clearer
>   and more correct with respect to how the hardware is designed. He also enables
>   the NAND controller on the bcm911360_entphn design, enables a bunch of
>   peripherals on the bcm958305k evaluation board, and adds a skeleton .dtsi file
>   for the touchscreen extansion board(s)
> 
> 

Merged into next/dt, thanks!

	Arnd
