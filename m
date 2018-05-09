From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Wed, 9 May 2018 01:34:06 -0700
Subject: [PATCH v7 19/24] ASoC: qdsp6: q6routing: Add support to MI2S
 Mixers
In-Reply-To: <20180501120820.11016-20-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-20-srinivas.kandagatla@linaro.org>
Message-ID: <a54f3aba-5a8a-5a69-2cbd-98244f4f7ed1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch add support to MI2S mixers required to select path between
> ASM stream and AFE ports.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6routing.c | 329 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 329 insertions(+)
>
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
