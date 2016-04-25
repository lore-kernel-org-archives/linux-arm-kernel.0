From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 21:12:10 +0200
Subject: [GIT PULL 3/4] Broadcom defconfig changes for 4.7
In-Reply-To: <1461441540-5095-3-git-send-email-f.fainelli@gmail.com>
References: <1461441540-5095-1-git-send-email-f.fainelli@gmail.com>
 <1461441540-5095-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <4947044.GuiSTQMvS9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 April 2016 12:58:59 Florian Fainelli wrote:
> This pull request contains defconfig changes for Broadcom ARM-based SoCs:
> 
> - Eric enables more BCM2835 peripherals in multi_v7_defconfig: watchdog, I2S,
>   switches from the sdhci-bcm2835 to the sdhci-iproc driver, DWC2 USB controller
> 
> - Eric also enables more BCM2835 peripherals in bcm2835_defconfig: VC4, NFS root
>   Power Management support, switching sdhci-bcm2835 for sdhci-iproc
> 
> 

Pulled into next/defconfig, thanks!

	Arnd
