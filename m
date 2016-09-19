From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 10:52:01 +0200
Subject: [GIT PULL 3/4] Broadcom devicetree changes for 4.9
In-Reply-To: <1473213558-11782-3-git-send-email-f.fainelli@gmail.com>
References: <1473213558-11782-1-git-send-email-f.fainelli@gmail.com>
 <1473213558-11782-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <11767334.P2mG8nZVoa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 6, 2016 6:59:17 PM CEST Florian Fainelli wrote:
> This pull request contains Broadcom ARM-based Device Tree changes for v4.9,
> please pull the following:
> 
> - Jon adds support for the Ethernet MAC DT nodes (AMAC) and provides the
>   following updates for Broadcom references boards:
>   * New Northstar Plus reference boards added: BCM958525er, BCM958522er,
>     BCM988312hr, BCM958623hr and BCM958622hr
>   * Add SATA nodes to the BCM958625hr and XMC boards
>   * Add I2C nodes to the XMC board
>   * Fixes the amount of RAM on BCM958625HR, BCM958625K and BCM958525XMC boards
>   * Add the GPIO reboot method for BCM958625hr and XMC boards
> 
> - Dhanajay adds PWM nodes for the Northstar Plus SoCs
> 
> - Rafal adds the USB 2.0 PHY to the BCM5301x Device Tree file include
> 
> - Stefan adds a missing USB clock to the BCM283x DT files, adds a DTSI file for
>   the USB host mode on BCM283x and finally documents and adds support for the
>   Raspberry Pi Zero
> 
> - Florian adds support for the Northstar Plus Switch Register Access block which
>   enables the integrated switch on these SoCs and enables the switch ports on the
>   BCM958625HR reference board
> 

I pulled this into next/dt last Thursday but forgot to send a notification.

Florian already asked me about on Friday, thanks a lot for paying attention!

	Arnd
