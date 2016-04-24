From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Apr 2016 23:57:46 +0200
Subject: [GIT PULL 1/4] Broadcom devicetree changes for 4.7
In-Reply-To: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
References: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <8783809.6sQz9I7Goh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 April 2016 12:58:57 Florian Fainelli wrote:
> This pull request contains Broadcom ARM-based SoC Device Tree changes:
> 
> - Rafal adds proper VCC GPIO to be fed to the USB host controllers for known
>   BCM5301x devices needing that, he also enables earlycon, and enables the
>   SPI-NOR flashes on relevant devices
> 
> - Eric adds the VideoCore 4 Device Tree nodes to the BCM283x Device Tree and
>   provides a DRM patch to kick out the simplefb framebuffer to avoid conflicts
> 
> - Stephan adds proper CPU nodes for the ARM processor on the BCM2835 SoC Device
>   Tree
> 
> - Martin provides a binding fix for the DMA channel interrupt numbers and
>   description
> 

Pulled into next/dt, thanks!

	Arnd
