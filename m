From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 17 Jul 2017 10:03:28 -0600
Subject: [PATCH v3 04/18] arm64: qcom-msm8916: dts: Update coresight
 replicator
In-Reply-To: <1500037463-19951-5-git-send-email-suzuki.poulose@arm.com>
References: <1500037463-19951-1-git-send-email-suzuki.poulose@arm.com>
 <1500037463-19951-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170717160328.GC21003@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 02:04:09PM +0100, Suzuki K Poulose wrote:
> Replace the obsolete compatible string for Coresight programmable
> replicator with the new one.
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: linux-arm-msm at vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 17691ab..a0db8c6 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -994,7 +994,7 @@
>  		};
>  
>  		replicator at 824000 {
> -			compatible = "qcom,coresight-replicator1x", "arm,primecell";
> +			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
>  			reg = <0x824000 0x1000>;
>  
>  			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.5
> 
