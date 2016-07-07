From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 15:50:33 +0200
Subject: [GIT PULL 3/4] Broadcom ARM64 Device Tree changes for 4.8 (part 2)
In-Reply-To: <1467862574-6522-2-git-send-email-f.fainelli@gmail.com>
References: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
 <1467862574-6522-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <18654891.srZ51jDrgX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 6, 2016 8:36:11 PM CEST Florian Fainelli wrote:
> This pull request contains the second part of the Broadcom ARM64-based SoCs
> changes for 4.8. Please note that this pull request contains changes from the
> ARM 32-bits port and ARM 64-bits port as well:

Ok, looks reasonable.

> - Lubomir updates all BCM2835 (Raspberry Pi family) Device Tree source files with
>   their proper information about the on-board USB Ethernet adapter so there is
>   appropriate binding between this USB device and a device_node (useful for MAC
>   address fetching and stuff), this commit is also present for the ARM DT pull
>   request
> 
> - Eric adds support for the Raspberry Pi 3 aka BCM2837 and provides the binding
>   information and the basic SoC DT include file required to boot to a prompt
> 
> - Gerd updates the Raspberry Pi 3 DT with Ethernet information based on the
>   earlier change from Lubomir

Pulled into next/dt64, thanks!

	Arnd
