From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Tue, 8 May 2018 19:40:48 -0700
Subject: [PATCH v7 09/24] ASoC: qdsp6: q6afe: Add q6afe driver
In-Reply-To: <20180501120820.11016-10-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-10-srinivas.kandagatla@linaro.org>
Message-ID: <d7aed12f-78d4-8528-bfab-3fc87a94e557@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to Q6AFE (Audio Front End) module on Q6DSP.
>
> AFE module sits right at the other end of cpu where the codec/audio
> devices are connected.
>
> AFE provides abstraced interfaces to both hardware and virtual devices.
> Each AFE tx/rx port can be configured to connect to one of the hardware
> devices like codec, hdmi, slimbus, i2s and so on. AFE services include
> starting, stopping, and if needed, any configurations of the ports.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig        |   4 +
>   sound/soc/qcom/qdsp6/Makefile |   1 +
>   sound/soc/qcom/qdsp6/q6afe.c  | 536 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.h  |  35 +++
>   4 files changed, 576 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6afe.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6afe.h
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
