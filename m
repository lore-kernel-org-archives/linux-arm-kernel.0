From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 19 Jun 2018 12:15:08 +0100
Subject: [PATCH] dt-bindings: Fix unbalanced quotation marks
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
Message-ID: <1d775530-e250-6397-8e60-4dac8d580f7d@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/06/18 15:31, Jonathan Neusch?fer wrote:
>   example:
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> index 6a4aadc4ce06..84b28dbe9f15 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt
> @@ -30,7 +30,7 @@ Required properties:
>   
>   			  Board connectors:
>   			  * Headset Mic
> -			  * Secondary Mic",
> +			  * Secondary Mic
>   			  * DMIC
>   			  * Ext Spk
>   
> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> index aa54e49fc8a2..c7600a93ab39 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> @@ -35,7 +35,7 @@ This binding describes the APQ8096 sound card, which uses qdsp for audio.
>   			"Digital Mic3"
>   
>   		Audio pins and MicBias on WCD9335 Codec:
> -			"MIC_BIAS1
> +			"MIC_BIAS1"
>   			"MIC_BIAS2"
>   			"MIC_BIAS3"
>   			"MIC_BIAS4"

for apq8016 and apq8096 parts:

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
