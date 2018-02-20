From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 20 Feb 2018 09:34:39 +0000
Subject: [alsa-devel] [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to
 Q6AFE
In-Reply-To: <2465335e-4d45-02d7-2e64-0a1c28a44ff1@codeaurora.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
 <2465335e-4d45-02d7-2e64-0a1c28a44ff1@codeaurora.org>
Message-ID: <2360f3a9-f207-bc84-b0da-2675b7c9f0e0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your review comments



On 19/02/18 10:30, Rohit Kumar wrote:
>> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
>> index d5280355c24f..748f5e891dcf 100644
>> --- a/sound/soc/qcom/Makefile
>> +++ b/sound/soc/qcom/Makefile
>> @@ -13,6 +13,11 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += 
>> snd-soc-lpass-apq8016.o
>>   # Machine
>>   snd-soc-storm-objs := storm.o
>>   snd-soc-apq8016-sbc-objs := apq8016_sbc.o
>> +snd-soc-msm8996-objs := apq8096.o
> This needs to be moved out of this patch

Will fix it in next version.

>>   obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
>>   obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
>> +obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-msm8996.o
>> +
>> +#DSP lib 
