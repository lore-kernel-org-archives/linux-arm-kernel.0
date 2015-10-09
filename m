From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 9 Oct 2015 09:48:17 +0100
Subject: [PATCH 4/4] arm64: dts: enable idle states for Hi6220
In-Reply-To: <1444365376-10728-5-git-send-email-leo.yan@linaro.org>
References: <1444365376-10728-1-git-send-email-leo.yan@linaro.org>
 <1444365376-10728-5-git-send-email-leo.yan@linaro.org>
Message-ID: <56177F51.1080806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/10/15 05:36, Leo Yan wrote:
> Add cpu and cluster level's low power state for Hi6220.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 7edbe42..e83802a 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -52,11 +52,35 @@
>   			};
>   		};
>
> +		idle-states {
> +			entry-method = "arm,psci";

Please refer the bindings:           ^ should be just "psci"

Otherwise looks good.
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
