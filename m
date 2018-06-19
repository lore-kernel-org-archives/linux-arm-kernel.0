From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue, 19 Jun 2018 17:49:39 +0200
Subject: [PATCH 2/3] ARM: dts: imx53: Add a label for the PMU node
In-Reply-To: <1529329939-14117-2-git-send-email-festevam@gmail.com>
References: <1529329939-14117-1-git-send-email-festevam@gmail.com>
 <1529329939-14117-2-git-send-email-festevam@gmail.com>
Message-ID: <20180619154939.fi63ve3xssfrf3qb@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 18, 2018 at 10:52:18AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Add a label for the PMU node so that the board dts may be able to
> pass the 'secure-reg-access' property like this:
> 
> &pmu {
> 	secure-reg-access;
> };
> 
> This also makes it consistent with the PMU node in imx6qdl.dtsi
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  arch/arm/boot/dts/imx53.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index a70fbf4..263bd39f 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -113,7 +113,7 @@
>  		};
>  	};
>  
> -	pmu {
> +	pmu: pmu {
>  		compatible = "arm,cortex-a8-pmu";
>  		interrupt-parent = <&tzic>;
>  		interrupts = <77>;
> -- 
> 2.7.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180619/46dda09f/attachment.sig>
