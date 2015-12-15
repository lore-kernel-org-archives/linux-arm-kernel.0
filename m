From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 17:46:44 +0100
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable some drivers for
 LS1021A
In-Reply-To: <1449650499-28660-1-git-send-email-b18965@freescale.com>
References: <1449650499-28660-1-git-send-email-b18965@freescale.com>
Message-ID: <4261942.cfn90bpvGM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 December 2015 16:41:39 Alison Wang wrote:
> This patch enables some drivers for LS1021A, such as
> GIANFAR, WATCHDOG, AUDIO, QSPI, I2C, ESDHC, EDMA, FTM.
> QorIQ Clock Framework and Ramdisk support is also enabled.
> 
> Signed-off-by: Alison Wang <alison.wang@freescale.com>
> 

Applied to next/defconfig, thanks!

	Arnd
