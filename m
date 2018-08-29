From: qiang.zhao@nxp.com (Qiang Zhao)
Date: Wed, 29 Aug 2018 08:57:40 +0000
Subject: [PATCH] soc: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
Message-ID: <VI1PR04MB3247DA20AA7C6242B90FA6DA91090@VI1PR04MB3247.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>
Date: 2018?8?28? 9:53
> To: linux-kernel at vger.kernel.org
> Cc: Qiang Zhao <qiang.zhao@nxp.com>; Leo Li <leoyang.li@nxp.com>; Andy
> Gross <andy.gross@linaro.org>; David Brown <david.brown@linaro.org>; Heiko
> Stuebner <heiko@sntech.de>; Thierry Reding <thierry.reding@gmail.com>;
> Jonathan Hunter <jonathanh@nvidia.com>; Santosh Shilimkar
> <ssantosh@kernel.org>; linuxppc-dev at lists.ozlabs.org;
> linux-arm-kernel at lists.infradead.org; linux-soc at vger.kernel.org
> Subject: [PATCH] soc: Convert to using %pOFn instead of device_node.name
> 
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-soc at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/soc/dove/pmu.c            |  8 +++---
>  drivers/soc/fsl/qe/qe_tdm.c       |  4 +--
>  drivers/soc/qcom/apr.c            |  2 +-
>  drivers/soc/rockchip/pm_domains.c | 44 +++++++++++++++----------------
>  drivers/soc/tegra/pmc.c           | 12 ++++-----
>  drivers/soc/ti/knav_dma.c         |  8 +++---
>  drivers/soc/ti/knav_qmss_queue.c  |  8 +++---
>  7 files changed, 43 insertions(+), 43 deletions(-)

For qe_tdm part
Acked-by: Qiang Zhao <qiang.zhao@nxp.com>
