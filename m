From: qiang.zhao@nxp.com (Qiang Zhao)
Date: Thu, 5 May 2016 02:31:27 +0000
Subject: [v9, 6/7] MAINTAINERS: add entry for Freescale SoC driver
In-Reply-To: <1462332274-13744-7-git-send-email-yangbo.lu@nxp.com>
References: <1462332274-13744-1-git-send-email-yangbo.lu@nxp.com>
 <1462332274-13744-7-git-send-email-yangbo.lu@nxp.com>
Message-ID: <AM3PR04MB1185B5352C395FE8951CA5A5917C0@AM3PR04MB1185.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-05-04 at 11:24 +0800, Yangbo Lu wrote:
> -----Original Message-----
> From: Yangbo Lu [mailto:yangbo.lu at nxp.com]
> Sent: Wednesday, May 04, 2016 11:25 AM
> To: linux-mmc at vger.kernel.org; linuxppc-dev at lists.ozlabs.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; linux-clk at vger.kernel.org; linux-i2c at vger.kernel.org;
> iommu at lists.linux-foundation.org; netdev at vger.kernel.org
> Cc: ulf.hansson at linaro.org; Scott Wood <oss@buserror.net>; Mark Rutland
> <mark.rutland@arm.com>; Rob Herring <robh+dt@kernel.org>; Russell King
> <linux@arm.linux.org.uk>; Jochen Friedrich <jochen@scram.de>; Joerg Roedel
> <joro@8bytes.org>; Claudiu Manoil <claudiu.manoil@freescale.com>; Bhupesh
> Sharma <bhupesh.sharma@freescale.com>; Qiang Zhao
> <qiang.zhao@nxp.com>; Kumar Gala <galak@codeaurora.org>; Santosh
> Shilimkar <ssantosh@kernel.org>; Yang-Leo Li <leoyang.li@nxp.com>; Xiaobo
> Xie <xiaobo.xie@nxp.com>; Yangbo Lu <yangbo.lu@nxp.com>
> Subject: [v9, 6/7] MAINTAINERS: add entry for Freescale SoC driver
> 
> Add maintainer entry for Freescale SoC driver including the QE library and the
> GUTS driver now. Also add maintainer for QE library.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v8:
> 	- Added this patch
> Changes for v9:
> 	- Added linux-arm mail list
> 	- Removed GUTS driver entry
> ---
>  MAINTAINERS | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42e65d1..ce91db7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4622,9 +4622,18 @@ F:	drivers/net/ethernet/freescale/fec_ptp.c
>  F:	drivers/net/ethernet/freescale/fec.h
>  F:	Documentation/devicetree/bindings/net/fsl-fec.txt
> 
> +FREESCALE SOC DRIVER
> +M:	Scott Wood <oss@buserror.net>
> +L:	linuxppc-dev at lists.ozlabs.org
> +L:	linux-arm-kernel at lists.infradead.org
> +S:	Maintained
> +F:	drivers/soc/fsl/
> +F:	include/linux/fsl/
> +
>  FREESCALE QUICC ENGINE LIBRARY
> +M:	Qiang Zhao <qiang.zhao@nxp.com>
>  L:	linuxppc-dev at lists.ozlabs.org
> -S:	Orphan
> +S:	Maintained
>  F:	drivers/soc/fsl/qe/
>  F:	include/soc/fsl/*qe*.h
>  F:	include/soc/fsl/*ucc*.h
> --
> 2.1.0.27.g96db324

I am ok!

-Zhao Qiang
