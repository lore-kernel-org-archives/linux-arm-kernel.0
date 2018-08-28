From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 28 Aug 2018 12:44:05 +0200
Subject: [PATCH] soc: Convert to using %pOFn instead of device_node.name
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
Message-ID: <20180828104405.GB9386@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 08:52:44PM -0500, Rob Herring wrote:
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

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180828/f505a4a7/attachment.sig>
