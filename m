From: robdclark@gmail.com (Rob Clark)
Date: Fri, 6 Oct 2017 14:08:39 -0400
Subject: [PATCH] arm64: dts: qcom: msm8916: Shrink mdp address length for
 msm8916
In-Reply-To: <20171006155751.31261-1-ctatlor97@gmail.com>
References: <20171006155751.31261-1-ctatlor97@gmail.com>
Message-ID: <CAF6AEGurDDN3fmifwX6wVhba=xfo5Gihd7Ex-rDO8qCT1sGm-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 6, 2017 at 11:57 AM, Craig Tatlor <ctatlor97@gmail.com> wrote:
> This shrinks the address size down to 89000 from its previous 90000
> which was mistakenly pulled from downstream.
>
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Acked-by: Rob Clark <robdclark@gmail.com>

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index dc3817593e14..47262757b09e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -814,7 +814,7 @@
>
>                         mdp: mdp at 1a01000 {
>                                 compatible = "qcom,mdp5";
> -                               reg = <0x1a01000 0x90000>;
> +                               reg = <0x1a01000 0x89000>;
>                                 reg-names = "mdp_phys";
>
>                                 interrupt-parent = <&mdss>;
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
