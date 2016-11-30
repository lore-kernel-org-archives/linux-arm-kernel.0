From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 17:55:00 +0100
Subject: [GIT PULL 2/6] Broadcom devicetree changes for 4.10
In-Reply-To: <20161122054824.16974-2-f.fainelli@gmail.com>
References: <20161122054824.16974-1-f.fainelli@gmail.com>
 <20161122054824.16974-2-f.fainelli@gmail.com>
Message-ID: <6352823.Z1eXLgpRkV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 21, 2016 9:48:20 PM CET Florian Fainelli wrote:
> This pull request contains Broadcom ARM-based SoC Device Tree changes for 4.10,
> please pull the following:
> 
> - Rafal adds support for the Netgear R8500 routers, adds basic support
>   for the Tenda AC9 router which uses the new BCM53573 SoC (single core Cortex
>   A7). He also enables the UART on the Netgear R8000 and restructures the
>   include files a bit for the BCM47094 SoC, finally he adds USB 3.0 PHY nodes
>   which enables USB 3.0 on BCM5301X devices that support it. Finally he adds
>   support for the TP-LINK Archer C9 V1 router.
> 
> - Kamal adds support for the QSPI controller on the Northstar Plus SoCs and updates
>   the bcm958625k reference board to have it enabled
> 
> - Dan adds support for the Luxul XAP-1510 (using a BCM4708) and XWR-3100 (using
>   a BCM47094)
> 
> - Scott fixes the pinctrl names in the Cygnus DTS files
> 
> - Jonathan enables the Broadcom iProc mailbox controller for Broadcom Cygnus/iProc
>   SoCs, he adds interrupt support for the GPIO CRMU hardware block and finally adds
>   the node for the OTP controller found on Cygnus SoCs
> 
> - Dhananjay enables the GPIO B controller on Norstarh Plus SoCs
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
>   Device Tree nodes he also fixes the Raspberry Pi GPIO lines names and finally
>   adds names for the Raspberry Zero GPIO lines
> 

Pulled into next/dt, thanks!

	Arnd
