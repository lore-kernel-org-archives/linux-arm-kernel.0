From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Thu, 22 Nov 2012 05:47:11 +0000
Subject: [PATCH v3 3/5] ARM: dts: AM33XX: Set pmic-shutdown-controller
 for BeagleBone
In-Reply-To: <1353404927-14412-4-git-send-email-anilkumar@ti.com>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
 <1353404927-14412-4-git-send-email-anilkumar@ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA78AAC@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 15:18:45, AnilKumar, Chimata wrote:
> Set ti,pmic-shutdown-controller for BeagleBone in am335x-bone.dts
> file, this flag is used by the driver to set tps65217 PMIC status
> to OFF when PWR_EN toggle.

Hi Tony,

Could you please pull these 3 patches? (3/5, 4/5 and 5/5)

Thanks
AnilKumar

> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-bone.dts |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 2c33888..1d55190 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -88,6 +88,8 @@
>  /include/ "tps65217.dtsi"
>  
>  &tps {
> +	ti,pmic-shutdown-controller;
> +
>  	regulators {
>  		dcdc1_reg: regulator at 0 {
>  			regulator-always-on;
> -- 
> 1.7.9.5
> 
> 
