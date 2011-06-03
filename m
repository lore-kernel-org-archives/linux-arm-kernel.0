From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jun 2011 18:15:49 +0200
Subject: [PATCH v3 2/4] mmc: support sdhci-pxav2.c
In-Reply-To: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com>
References: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <201106031815.50064.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 June 2011, Zhangfei Gao wrote:
>         SDHCI driver for pxav2 SoCs, such as pxa910, the driver based on sdhci-pltfm to handle resource etc.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> Signed-off-by: Jun Nie <njun@marvell.com>
> Signed-off-by: Qiming Wu <wuqm@marvell.com>
> ---
>  drivers/mmc/host/Kconfig       |   11 ++
>  drivers/mmc/host/Makefile      |    1 +
>  drivers/mmc/host/sdhci-pxav2.c |  261 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 273 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-pxav2.c
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
