From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 16:27:22 +0000
Subject: [RESEND PATCH v2 13/15] dt-bindings: sound: qcom: Add devicetree
 bindings for apq8096
In-Reply-To: <20180103002835.GW478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-14-srinivas.kandagatla@linaro.org>
 <20180103002835.GW478@tuxbook>
Message-ID: <787ecdc5-66d8-23ee-7136-2a8759c86536@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/01/18 00:28, Bjorn Andersson wrote:
> On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla at linaro.org wrote:
> 
>> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> 
> Wouldn't it be possible to describe all(?) qdsp based machines in this
> one document? I.e. should we name it a little bit more generic?

You mean like downstream ?

I see no harm in trying it out and see how it looks like.

> 
>> @@ -0,0 +1,22 @@
>> +* Qualcomm Technologies APQ8096 ASoC sound card driver
>> +
>> +This binding describes the APQ8096 sound card, which uses qdsp for audio.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,apq8096-sndcard"
>> +
>> +- qcom,audio-routing:
>> +	Usage: Optional
>> +	Value type: <stringlist>
>> +	Definition:  A list of the connections between audio components.
> 
> Double space before A
yep.

> 
>> +		  Each entry is a pair of strings, the first being the
>> +		  connection's sink, the second being the connection's
>> +		  source. Valid names could be power supplies, MicBias
>> +		  of codec and the jacks on the board:
>> +Example:
>> +	sound {
>> +		compatible	= "qcom,snd-apq8096";
> 
> Indentation
yep.

> 
>> +		qcom,model = "DB820c";
>> +	};
> 
> Regards,
> Bjorn
> 
