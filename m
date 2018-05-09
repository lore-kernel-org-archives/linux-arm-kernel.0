From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Wed, 9 May 2018 02:57:13 -0700
Subject: [PATCH v7 21/24] ASoC: qdsp6: q6asm: Add q6asm dai driver
In-Reply-To: <20180501120820.11016-22-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-22-srinivas.kandagatla@linaro.org>
Message-ID: <d4972fcf-c513-83db-4770-8009b5ab6d76@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to q6asm dai driver which configures Q6ASM streams
> to pass pcm data.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig           |   4 +
>   sound/soc/qcom/qdsp6/Makefile    |   1 +
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 628 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 633 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6asm-dai.c
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
