From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Thu, 3 May 2018 18:35:10 -0700
Subject: [PATCH v7 07/24] ASoC: qdsp6: q6common: Add qdsp6 helper functions
In-Reply-To: <20180501120820.11016-8-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-8-srinivas.kandagatla@linaro.org>
Message-ID: <28f86f87-b28e-bec8-1a74-a218afeac0cc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds some common helper functions like translating dsp error
> to linux error codes and channel mappings etc.
>
> These functions are used in all the following qdsp6 drivers.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig              | 13 ++++++++
>   sound/soc/qcom/Makefile             |  3 ++
>   sound/soc/qcom/qdsp6/Makefile       |  1 +
>   sound/soc/qcom/qdsp6/q6dsp-common.c | 66 +++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6dsp-common.h | 24 ++++++++++++++
>   sound/soc/qcom/qdsp6/q6dsp-errno.h  | 51 ++++++++++++++++++++++++++++
>   6 files changed, 158 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/Makefile
>   create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.h
>   create mode 100644 sound/soc/qcom/qdsp6/q6dsp-errno.h
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
