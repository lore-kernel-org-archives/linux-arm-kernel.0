From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 09:57:26 +0100
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable some drivers for
 LS1021A
In-Reply-To: <1449650499-28660-1-git-send-email-b18965@freescale.com>
References: <1449650499-28660-1-git-send-email-b18965@freescale.com>
Message-ID: <5410635.RmBCMMyZr3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 December 2015 16:41:39 Alison Wang wrote:
> This patch enables some drivers for LS1021A, such as
> GIANFAR, WATCHDOG, AUDIO, QSPI, I2C, ESDHC, EDMA, FTM.
> QorIQ Clock Framework and Ramdisk support is also enabled.
> 
> Signed-off-by: Alison Wang <alison.wang@freescale.com>
> ---
> Changes since v1:
> - Make some drivers as loadable modules.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Shawn, do you want to pick this up and send it back through the
imx tree?

If you have no other defconfig changes for 4.5, we can also just
add it to arm-soc.

	Arnd
