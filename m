From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 7 Feb 2018 11:40:09 +0000
Subject: [alsa-devel] [RESEND PATCH v2 11/15] ASoC: qcom: qdsp6: Add
 support to q6afe dai driver
In-Reply-To: <33dbc1d9-ec33-b779-9258-4d1b13e17aaa@codeaurora.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-12-srinivas.kandagatla@linaro.org>
 <33dbc1d9-ec33-b779-9258-4d1b13e17aaa@codeaurora.org>
Message-ID: <55b292b3-7826-2757-bf79-1128baaa3f07@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/02/18 11:34, Rohit Kumar wrote:
>> +
>> +module_platform_driver(q6afe_dai_driver);
> MODULE_LICENSE missing.

Thanks Rohit, I have included this in v3.
