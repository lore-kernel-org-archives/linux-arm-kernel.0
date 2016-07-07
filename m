From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 15:58:34 +0200
Subject: [GIT PULL 5/4] Broadcom soc-arm64 changes for 4.8 part 2
In-Reply-To: <1467867851-11298-1-git-send-email-f.fainelli@gmail.com>
References: <1467862574-6522-1-git-send-email-f.fainelli@gmail.com>
 <1467867851-11298-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <3314738.osW38YoyUP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 6, 2016 10:04:11 PM CEST Florian Fainelli wrote:
> This pull requests contains Broadcom ARM64-based SoC changes for 4.8 second part:
> 
> - Eric updates the bcm2836 interrupt controller driver not to rely on ARM/Linux specific functions
>   in preparation for using it on ARM64
> 
> - Eric also adds a Kconfig entry for the BCM2835 Raspberry Pi family in the ARM64 Kconfig.platforms
>   file
> 
> - Eric cherry picked a patch from Alexander Graf with Acks from ARM64 maintainers to support different
>   DMA and bus offsets, required for the Raspberry Pi 3 SoC
> 
> 

Pulled into next/arm64, thanks!

	Arnd
