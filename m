From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 23:49:19 +0200
Subject: [GIT PULL 4/4] Broadcom drivers changes for 4.7
In-Reply-To: <1461441540-5095-4-git-send-email-f.fainelli@gmail.com>
References: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
 <1461441540-5095-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <6002710.ZtNXPrPtLO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 April 2016 12:59:00 Florian Fainelli wrote:
> This pull request contains Broadcom ARM-based SoCs drivers changes:
> 
> - Justin adds a soc_dev driver to properly report to user-space the Broadcom
>   STB SoC family, product and revision
> 
> - Florian reworks how the brcmstb_gisb driver dependency is done to enable it
>   on Broadcom STB MIPS-based SoCs and remove a select in
>   arch/arm/mach-bcm/Kconfig
> 

Pulled into next/drivers, thanks!

	Arnd
