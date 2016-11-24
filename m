From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Nov 2016 10:56:04 +0100
Subject: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
In-Reply-To: <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
Message-ID: <2204525.IWIYQVjIXl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 31, 2016 12:09:56 PM CET Gregory CLEMENT wrote:
> From: Ziji Hu <huziji@marvell.com>
> 
> Marvell Xenon eMMC/SD/SDIO Host Controller contains PHY.
> Three types of PHYs are supported.
> 
> Add support to multiple types of PHYs init and configuration.
> Add register definitions of PHYs.
> 
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 

Please explain in the changelog why this is not a generic
phy driver (or three of them).

	Arnd
