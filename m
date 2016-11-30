From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 18:00:23 +0100
Subject: [GIT PULL 3/6] Broadcom devicetree-arm64 changes for 4.10
In-Reply-To: <20161122054824.16974-3-f.fainelli@gmail.com>
References: <20161122054824.16974-1-f.fainelli@gmail.com>
 <20161122054824.16974-3-f.fainelli@gmail.com>
Message-ID: <6243216.EMKdABgK8f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 21, 2016 9:48:21 PM CET Florian Fainelli wrote:
> This pull request contains Broadcom ARM64 based SoC Device Tree changes for
> 4.10, please pull the following:
> 
> - Robin updates the Northstart 2 DTS to use the generic IOMMU binding
> 
> - Scott renames the Broadcom Northstar 2 binding document to use a standard name
>   including the brcm vendor prefix
> 
> - Kamal adds the QSPI Device Tree node to the Northstar 2 SoC and updates the
>   Northstar 2 SVK reference board DTS file with it enabled.
> 
> - Rob adds the Device Tree node for the Broadcom PDC (mailbox) hardware to the
>   Northstar 2 SoC
> 
> - Jon enables the SDIO1 block and adds proper PCIe PHYs Device Tree nodes to the
>   Northstar 2 SoC
> 
> - Ray adds required properties NAND controller properties to make NAND work on
>   the Northstar 2 SVK board, this was submitted as a 4.9 fixes and is included
>   here to resolve DTS file merges
> 
> - Andrea removes an incorrect power LED from the Raspberry Pi 3 DTS
> 
> - Andreas fixes the compatible string for the BCM2837 (Raspberry Pi 3)
> 
> - Eric defines standard pinctrl groups in the BCM2835 GPIO node
> 
> - Gerd adds definitions for the pinctrl groups and updates the PWM, I2C and SDHCI nodes
>   to use their appropriate pinctrl functions
> 
> - Linus adds names for the Raspberry Pi GPIO lines based on the datasheet
> 
> - Martin adds the DT binding and nodes for the Raspberry Pi firmware thermal block
> 
> - Stefan fixes a few typos with respect to the BCM2835 mailbox binding example and
>   Device Tree nodes he also uses the proper DTSI file to define the USB host mode
>   for the USB Device Tree nodes
> 
> 

Pulled into next/dt64, thanks!

	Arnd
