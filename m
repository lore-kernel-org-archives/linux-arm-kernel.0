From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 22 Feb 2018 11:13:21 +0000
Subject: [alsa-devel] [PATCH v3 24/25] ASoC: qcom: apq8096: Add db820c
 machine driver
In-Reply-To: <2d646729-9bb2-86e5-22f5-19aaf009c0cc@codeaurora.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-25-srinivas.kandagatla@linaro.org>
 <2d646729-9bb2-86e5-22f5-19aaf009c0cc@codeaurora.org>
Message-ID: <d3727be9-b8d1-68f1-d862-c6f5e3a83fea@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review,

On 22/02/18 11:00, Rohit Kumar wrote:
>> +config SND_SOC_MSM8996
>> +    tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
>> +    depends on QCOM_APR
>> +    select SND_SOC_QDSP6V2
> should be select SND_SOC_QDSP6, V2 is not defined

I will fix this in next version.

--srini
