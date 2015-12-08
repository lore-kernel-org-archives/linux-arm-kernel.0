From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 10:29:51 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Enable some drivers for LS1021A
In-Reply-To: <1449563883-29317-1-git-send-email-b18965@freescale.com>
References: <1449563883-29317-1-git-send-email-b18965@freescale.com>
Message-ID: <3400541.YhcYNk5DCk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 December 2015 16:38:03 Alison Wang wrote:
> This patch enables some drivers for LS1021A, such as
> GIANFAR, WATCHDOG, AUDIO, QSPI, I2C, ESDHC, EDMA, FTM.
> QorIQ Clock Framework and Ramdisk support is also enabled.
> 
> Signed-off-by: Alison Wang <alison.wang@freescale.com>
> ---

I think most of these can be made loadable modules, please do that
and only leave as much built-in as you need for booting.

Otherwise looks ok.

	Arnd
