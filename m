From: sebastien.szymanski@armadeus.com (=?UTF-8?Q?S=c3=a9bastien_Szymanski?=)
Date: Tue, 18 Sep 2018 09:57:51 +0200
Subject: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz
 operating point
In-Reply-To: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
References: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <b145ac3a-279e-ddbe-770b-08d18fa10feb@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2018 10:13 AM, Anson Huang wrote:
> Update VDD_SOC voltage to 1.25V for 900MHz operating point
> according to datasheet Rev. 1.3, 08/2018, 25mV is added to
> the minimum allowed values to cover power supply ripple.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ull.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
> index cd1776a..796ed35 100644
> --- a/arch/arm/boot/dts/imx6ull.dtsi
> +++ b/arch/arm/boot/dts/imx6ull.dtsi
> @@ -22,7 +22,7 @@
>  	>;
>  	fsl,soc-operating-points = <
>  		/* KHz	uV */
> -		900000	1175000
> +		900000	1250000
>  		792000	1175000
>  		528000	1175000
>  		396000	1175000
> 

Reviewed-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>

-- 
S?bastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26
