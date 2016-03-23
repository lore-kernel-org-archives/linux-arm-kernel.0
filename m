From: robh@kernel.org (Rob Herring)
Date: Wed, 23 Mar 2016 10:22:17 -0500
Subject: [PATCH 1/2 v6] dt/bindings: Add bindings for Layerscape SCFG MSI
In-Reply-To: <1458731300-13648-1-git-send-email-Minghuan.Lian@nxp.com>
References: <1458731300-13648-1-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <20160323152217.GA23919@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 07:08:19PM +0800, Minghuan Lian wrote:
> Some Layerscape SoCs use a simple MSI controller implementation.
> It contains only two SCFG register to trigger and describe a
> group 32 MSI interrupts. The patch adds bindings to describe
> the controller.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> change log:
> v6-v4: no change
> v4: add interrupt-parent description
> v3-v1: no change
>  
>  .../interrupt-controller/fsl,ls-scfg-msi.txt       | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt

Acked-by: Rob Herring <robh@kernel.org>
