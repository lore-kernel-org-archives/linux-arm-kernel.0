From: russ.dill@gmail.com (Russ Dill)
Date: Wed, 7 Aug 2013 17:53:13 -0700
Subject: [PATCHv3 3/9] ARM: OMAP: DTB: Update IRQ data for WKUP_M3
In-Reply-To: <1375811376-49985-4-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-4-git-send-email-d-gerlach@ti.com>
Message-ID: <CA+Bv8XbBPGtMnFfPtsFH_3-=v_0jBmruVFgUBY5Ycx-a_yr4LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 6, 2013 at 10:49 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> Allow interrupt for wkup_m3 to be set from DT.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Cc: Benoit Cousson <benoit.cousson@linaro.org>

Reviewed-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/boot/dts/am33xx.dtsi |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 38b446b..05353bf 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -491,6 +491,7 @@
>                         compatible = "ti,am3353-wkup-m3";
>                         reg = <0x44d00000 0x4000        /* M3 UMEM */
>                                0x44d80000 0x2000>;      /* M3 DMEM */
> +                       interrupts = <78>;
>                         ti,hwmods = "wkup_m3";
>                 };
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
