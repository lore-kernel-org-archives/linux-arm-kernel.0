From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 17 Jul 2017 10:01:30 -0600
Subject: [PATCH v3 02/18] arm64: juno: dts:  Use the new coresight
 replicator string
In-Reply-To: <1500037463-19951-3-git-send-email-suzuki.poulose@arm.com>
References: <1500037463-19951-1-git-send-email-suzuki.poulose@arm.com>
 <1500037463-19951-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170717160129.GA21003@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 02:04:07PM +0100, Suzuki K Poulose wrote:
> Use the new compatible for ATB programmable replicator in Juno.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index bfe7d68..c82c706 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -373,7 +373,7 @@
>  	};
>  
>  	replicator at 20120000 {
> -		compatible = "qcom,coresight-replicator1x", "arm,primecell";
> +		compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
>  		reg = <0 0x20120000 0 0x1000>;
>  
>  		clocks = <&soc_smc50mhz>;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.5
> 
