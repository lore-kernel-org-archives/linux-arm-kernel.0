From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Thu, 3 May 2018 16:45:14 -0700
Subject: [PATCH v7 03/24] ASoC: qdsp6: dt-bindings: Add q6core dt bindings
In-Reply-To: <20180501120820.11016-4-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-4-srinivas.kandagatla@linaro.org>
Message-ID: <88da0352-d5f9-8c02-9dbf-ec4667d66271@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/1/2018 5:07 AM, Srinivas Kandagatla wrote:
> This patch add DT bindings for Q6CORE DSP module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/sound/qcom,q6core.txt       | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6core.txt b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
> new file mode 100644
> index 000000000000..bd14e9a93490
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
> @@ -0,0 +1,21 @@
> +Qualcomm ADSP Core service binding
> +
> +Q6CORE is one of the APR audio service on Q6DSP.
> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
Correct "coommon" to "common". Otherwise looks good.
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
