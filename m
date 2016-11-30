From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 22:23:54 +0100
Subject: [GIT PULL 6/6] Broadcom defconfig-arm64 changes for 4.10
In-Reply-To: <20161122054824.16974-6-f.fainelli@gmail.com>
References: <20161122054824.16974-1-f.fainelli@gmail.com>
 <20161122054824.16974-6-f.fainelli@gmail.com>
Message-ID: <5169145.yiI3Dl3Z7s@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 21, 2016 9:48:24 PM CET Florian Fainelli wrote:
> This pull request contains Broadcom ARM64-based SoCs defconfig changes for 4.10,
> please pull the following changes:
> 
> - Eric updates the ARMv8 defconfig to contain everything that is needed to run
>   a 64-bit kernel on the Raspberry Pi 3
> 
> - Scott enables the standard AT25 EEPROM driver as module for the ARM64 defconfig
> 
> - Martin enables the Raspberry Pi Thermal driver in the ARM64 defconfig
> 

Pulled into next/arm64, thanks!

	Arnd
