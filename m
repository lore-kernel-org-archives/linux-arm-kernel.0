From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 15:33:06 +0200
Subject: [GIT PULL 1/4] Broadcom ARM devicetree changes for 4.8 (part 2)
In-Reply-To: <1467862574-6522-3-git-send-email-f.fainelli@gmail.com>
References: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
 <1467862574-6522-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <6897112.NgkIrFBA8T@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 6, 2016 8:36:12 PM CEST Florian Fainelli wrote:
> This pull request contains additional Broadcom ARM-based SoC Device Tree changes:
> 
> - Lubomir updates all BCM2835 (Raspberry Pi family) Device Tree source files with
>   their proper information about the on-board USB Ethernet adapter so there is
>   appropriate binding between this USB device and a device_node (useful for MAC
>   address fetching and stuff)
> 
> - Raveendra adds the ADC controller Device Tree nodes to the Cygnus SoC device
>   tree include files
> 
> - Rafal updates the BCM5301x Device Tree by separating how we specify the NAND
>   chip-select information in a first change and then fixes the NAND controller
>   ECC configuration for the D-Link DIR-885L
> 
> - Florian adds support for the BCM953012ER reference board, adds the HW random
>   number generator DT node and adds proper memory node information to the
>   BCM958625HR reference board
> 

Nice changelog text!

Pulled into next/dt, thanks,

	Arnd
