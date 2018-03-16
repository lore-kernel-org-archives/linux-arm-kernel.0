From: absahu@codeaurora.org (Abhishek Sahu)
Date: Fri, 16 Mar 2018 15:49:29 +0530
Subject: [PATCH v2 03/13] ARM: dts: ipq4019: Change the max opp frequency
In-Reply-To: <1521193101-4586-4-git-send-email-sricharan@codeaurora.org>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-4-git-send-email-sricharan@codeaurora.org>
Message-ID: <77ec3dbe81448b43eb22297731bc5c96@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-16 15:08, Sricharan R wrote:
> The max opp frequency is 716MHZ. So update that.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

  Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>

> ---
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index e38fffa..2ee71c2 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -47,7 +47,7 @@
>  				48000	1100000
>  				200000	1100000
>  				500000	1100000
> -				666000	1100000
> +				716000  1100000
>  			>;
>  			clock-latency = <256000>;
>  		};
