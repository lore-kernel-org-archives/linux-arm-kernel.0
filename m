From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 17 Jul 2017 10:02:28 -0600
Subject: [PATCH v3 03/18] arm: qcom-msm8974: dts: Update coresight
 replicator
In-Reply-To: <1500037463-19951-4-git-send-email-suzuki.poulose@arm.com>
References: <1500037463-19951-1-git-send-email-suzuki.poulose@arm.com>
 <1500037463-19951-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170717160228.GB21003@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 02:04:08PM +0100, Suzuki K Poulose wrote:
> Replace the obsolete compatible string for Coresight programmable
> replicator with the new one.
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: linux-arm-msm at vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 307bf6a..3c7c6b9 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -729,7 +729,7 @@
>  		};
>  
>  		replicator at fc31c000 {
> -			compatible = "qcom,coresight-replicator1x", "arm,primecell";
> +			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
>  			reg = <0xfc31c000 0x1000>;
>  
>  			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.5
> 
