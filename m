From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 22:25:23 +0200
Subject: [PATCH] ARM: configs: update lpc18xx defconfig
In-Reply-To: <1444596042-31904-1-git-send-email-manabian@gmail.com>
References: <1444596042-31904-1-git-send-email-manabian@gmail.com>
Message-ID: <5050204.17mgtSjSoc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 October 2015 22:40:41 Joachim Eastwood wrote:
> - Enable SPIFI Flash and JFFS2 to support rootfs on Flash memory
> - Enable USB Phy, mass storage and SCSI to support USB memory
> - Enable PCF857x and JC42 I2C devices found on Hitex board
> - Enable PL172 to support memory mapped NOR Flash
> - New LPC18xx drivers: I2C, Watchdog, SCT PWM and RTC
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> Hi arm-soc team,
> 
> Please apply this single defconfig update for lpc18xx to
> arm-soc/defconfig for v4.4.
> 

Applied to next/defconfig, thanks!

	Arnd
