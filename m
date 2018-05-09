From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 9 May 2018 10:43:32 +0100
Subject: [PATCH v7 20/24] ASoC: qdsp6: q6afe: Add q6afe dai driver
In-Reply-To: <22a39a17-36ef-3e94-e91b-11d303559ae4@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-21-srinivas.kandagatla@linaro.org>
 <22a39a17-36ef-3e94-e91b-11d303559ae4@codeaurora.org>
Message-ID: <28faf045-a053-0918-70d3-1ef6fcdb13b8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/05/18 10:42, Banajit Goswami wrote:
>> +
>> +static int msm_dai_q6_dai_probe(struct snd_soc_dai *dai)
>> +{
>> +    struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
>> +    struct snd_soc_dapm_context *dapm;
>> +    struct q6afe_port *port;
>> +
>> +    dapm = snd_soc_component_get_dapm(dai->component);
> dapm unused here?
> 
I already removed this in v8.

thanks,
srini

> LGTM otherwise.
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
> 
> -- 
