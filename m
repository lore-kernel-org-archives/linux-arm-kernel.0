From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 18:07:42 -0700
Subject: [PATCH 3/6] clk: mediatek: export cpu multiplexer clock for
 MT8173 SoCs
In-Reply-To: <1493997974-17699-4-git-send-email-sean.wang@mediatek.com>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
 <1493997974-17699-4-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170620010742.GD4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> The patch enables CPU multiplexer clock on MT8173 SoC which fixes up
> cpufreq driver fails at acquiring intermediate clock source when driver
> probe is called.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
