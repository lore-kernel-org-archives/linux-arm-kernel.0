From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Tue, 8 May 2018 21:29:50 -0700
Subject: [PATCH v7 12/24] ASoC: qdsp6: q6afe: Add support to MI2S sysclks
In-Reply-To: <20180501120820.11016-13-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-13-srinivas.kandagatla@linaro.org>
Message-ID: <5e4cd4a7-c375-4b92-f28b-f34900a828a8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to LPASS Bit clock, LPASS Digital
> core clock and OSR clock. These clocks are required for both
> MI2S and PCM setup.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6afe.c | 171 +++++++++++++++++++++++++++++++++++++++++--
>   sound/soc/qcom/qdsp6/q6afe.h | 131 +++++++++++++++++++++++++++++++++
>   2 files changed, 295 insertions(+), 7 deletions(-)
>
>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
