From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 18:09:26 +0100
Subject: [GIT PULL 2/4] Broadcom devicetree changes for v4.5
In-Reply-To: <1449532649-6471-2-git-send-email-f.fainelli@gmail.com>
References: <1449532649-6471-1-git-send-email-f.fainelli@gmail.com>
 <1449532649-6471-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <3951676.ctkyyqj3vu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 December 2015 15:57:27 Florian Fainelli wrote:
> This pull request contains the Broadcom ARM-based Device Tree changes for 4.5:
> 
> - Jon Mason enables the following for Broadcom Northstar Plus SoCs: PCI (using
>   iProc PCI), NAND flash controller (BRCMNAND), TWD Timer and Watchdog
>   (Cortex-A9), I2C (iProc), clock providers, does some Device Tree cleanups
>   (re-parenting, fixing register sizes and hierarchy)
> 
> - Jon Mason also adds support for some reference Broadcom Northstar reference
>   designs like the BCM5301X SVK reference boards, updates the existing binding
>   documentation to cover the Northstar chips: 4708, 4709 and 53012.
> 
> - Pramod Kumar adds the GPIO to pinctrl mapping for the Broadcom Northstar Plus
>   SoCs
> 
> - Yendapally Reddy Dhananjaya Reddy adds pinctrl Device Tree nodes for the
>   Broadcom Northstar Plus SoCs device tree nodes
> 
> - Ray Jui adds Cygnus PCIe PHY Device Tree nodes and enables MSI for the iProc
>   PCI controller on Cygnus platforms
> 
> - Kapil Hali adds SMP binding documentation and Device Tree nodes for the
>   Northstar Plus SoCs
> 
> - Florian Fainelli adds clock provider support for the Broadcom BCM63138 DSL
>   SoCs by utilizing the existing iProc ARM PLL controller, this includes a
>   stable topic branch from Stephen Boyd to be merged
> 
> - Rafal Milecki adds missing LEDs for the Netgear R8000 router
> 
> 

Pulled into next/dt, thanks!

	Arnd
