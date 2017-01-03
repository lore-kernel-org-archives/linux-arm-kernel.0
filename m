From: robh@kernel.org (Rob Herring)
Date: Tue, 3 Jan 2017 11:12:58 -0600
Subject: [PATCH 6/9] arm64: dts: ls1046a: add MSI dts node
In-Reply-To: <1482829985-24421-6-git-send-email-Minghuan.Lian@nxp.com>
References: <1482829985-24421-1-git-send-email-Minghuan.Lian@nxp.com>
 <1482829985-24421-6-git-send-email-Minghuan.Lian@nxp.com>
Message-ID: <20170103171258.h5djzsarokjjldjx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 05:13:02PM +0800, Minghuan Lian wrote:
> LS1046a includes 3 MSI controllers.
> Each controller supports 128 interrupts.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  .../interrupt-controller/fsl,ls-scfg-msi.txt       |  1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 31 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> index 2755cd1..54597b0 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> @@ -6,6 +6,7 @@ Required properties:
>  	      Layerscape PCIe MSI controller block such as:
>                "fsl,ls1021a-msi"
>                "fsl,ls1043a-msi"
> +	      "fsl,ls1046a-msi"

Differing whitespace.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org> 
