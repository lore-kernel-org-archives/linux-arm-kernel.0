From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 2 Jan 2018 16:28:35 -0800
Subject: [RESEND PATCH v2 13/15] dt-bindings: sound: qcom: Add devicetree
 bindings for apq8096
In-Reply-To: <20171214173402.19074-14-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-14-srinivas.kandagatla@linaro.org>
Message-ID: <20180103002835.GW478@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla at linaro.org wrote:

> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt

Wouldn't it be possible to describe all(?) qdsp based machines in this
one document? I.e. should we name it a little bit more generic?

> @@ -0,0 +1,22 @@
> +* Qualcomm Technologies APQ8096 ASoC sound card driver
> +
> +This binding describes the APQ8096 sound card, which uses qdsp for audio.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,apq8096-sndcard"
> +
> +- qcom,audio-routing:
> +	Usage: Optional
> +	Value type: <stringlist>
> +	Definition:  A list of the connections between audio components.

Double space before A

> +		  Each entry is a pair of strings, the first being the
> +		  connection's sink, the second being the connection's
> +		  source. Valid names could be power supplies, MicBias
> +		  of codec and the jacks on the board:
> +Example:
> +	sound {
> +		compatible	= "qcom,snd-apq8096";

Indentation

> +		qcom,model = "DB820c";
> +	};

Regards,
Bjorn
