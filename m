From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Wed, 9 May 2018 01:39:55 -0700
Subject: [PATCH v7 18/24] ASoC: qdsp6: q6routing: Add support to all
 SLIMBus Mixers
In-Reply-To: <20180501120820.11016-19-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-19-srinivas.kandagatla@linaro.org>
Message-ID: <b40ae86f-de73-3432-131b-4efc4cee656a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to SLIMBus related mixers to control mux between
> ASM stream and AFE port.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6routing.c | 261 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 261 insertions(+)
>
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
