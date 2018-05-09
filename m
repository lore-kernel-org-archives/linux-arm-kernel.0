From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Tue, 8 May 2018 19:55:55 -0700
Subject: [PATCH v7 10/24] ASoC: qdsp6: qdafe: Add SLIMBus port Support
In-Reply-To: <20180501120820.11016-11-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-11-srinivas.kandagatla@linaro.org>
Message-ID: <448ccddb-b28d-65c9-f502-755b3403f72a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to 6 SLIMBus AFE ports, which are used as
> backend dais.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6afe.c | 129 +++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.h |  14 +++++
>   2 files changed, 143 insertions(+)
>
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
