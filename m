From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Oct 2018 17:08:45 -0500
Subject: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
 controller bindings
In-Reply-To: <20181011094655.45707-7-peng.ma@nxp.com>
References: <20181011094655.45707-1-peng.ma@nxp.com>
 <20181011094655.45707-7-peng.ma@nxp.com>
Message-ID: <20181011220845.GA20860@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2018 at 05:46:55PM +0800, Peng Ma wrote:
> Document the devicetree bindings for NXP Layerscape qDMA controller
> which could be found on NXP QorIQ Layerscape SoCs.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

What happened to the version from Wen He that was on v7 and that I 
already gave my Reviewed-by on?

> ---
>  Documentation/devicetree/bindings/dma/fsl-qdma.txt |   53 ++++++++++++++++++++
>  1 files changed, 53 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt
