From: peng.ma@nxp.com (Peng Ma)
Date: Fri, 12 Oct 2018 02:25:25 +0000
Subject: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
 controller bindings
In-Reply-To: <20181011220845.GA20860@bogus>
References: <20181011094655.45707-1-peng.ma@nxp.com>
 <20181011094655.45707-7-peng.ma@nxp.com> <20181011220845.GA20860@bogus>
Message-ID: <VI1PR04MB44310889ACCA73AFB29CAEEFEDE20@VI1PR04MB4431.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: 2018?10?12? 6:09
> To: Peng Ma <peng.ma@nxp.com>
> Cc: vkoul at kernel.org; Leo Li <leoyang.li@nxp.com>; mark.rutland at arm.com;
> shawnguo at kernel.org; dan.j.williams at intel.com; zw at zh-kernel.org;
> dmaengine at vger.kernel.org; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linuxppc-dev at lists.ozlabs.org
> Subject: Re: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
> controller bindings
> 
> On Thu, Oct 11, 2018 at 05:46:55PM +0800, Peng Ma wrote:
> > Document the devicetree bindings for NXP Layerscape qDMA controller
> > which could be found on NXP QorIQ Layerscape SoCs.
> >
> > Signed-off-by: Peng Ma <peng.ma@nxp.com>
> 
> What happened to the version from Wen He that was on v7 and that I already
> gave my Reviewed-by on?

[Peng Ma] the dma owner is changed and qdma driver made some changes, so I need send those patch again to review!

Best regards
	Peng Ma
> 
> > ---
> >  Documentation/devicetree/bindings/dma/fsl-qdma.txt |   53
> ++++++++++++++++++++
> >  1 files changed, 53 insertions(+), 0 deletions(-)  create mode 100644
> > Documentation/devicetree/bindings/dma/fsl-qdma.txt
