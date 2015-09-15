From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Tue, 15 Sep 2015 05:57:02 +0000
Subject: [linuxppc-release] [PATCH] arm64: dts: fsl-ls2085a: Add serial
 aliases
In-Reply-To: <20150915004827.GA19862@home.buserror.net>
References: <20150915004827.GA19862@home.buserror.net>
Message-ID: <BN3PR0301MB1298D188667AF2F48ED54933825C0@BN3PR0301MB1298.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: linuxppc-release-bounces at linux.freescale.net [mailto:linuxppc-
> release-bounces at linux.freescale.net] On Behalf Of Scott Wood
> Sent: Tuesday, September 15, 2015 6:18 AM
> 
> These will allow U-Boot to set linux,stdout-path in /chosen based on the
> active console device, which will allow devicetree-based earlycon.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> index e281ceb..eae454e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2085a.dtsi
> @@ -55,6 +55,11 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
> 
> +	aliases {
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +	};
> +
>  	cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
> --

Rebase this to my LS2080A v2 DTS sent some time ago, as LS2085A is now renamed to LS2080A.

Regards,
Bhupesh
