From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 18:07:37 -0700
Subject: [PATCH 1/6] clk: mediatek: add missing cpu mux causing Mediatek
 cpufreq can't work
In-Reply-To: <1493997974-17699-2-git-send-email-sean.wang@mediatek.com>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
 <1493997974-17699-2-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170620010737.GB4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This patch adds CPU multiplexer clocks which are essential for Mediatek
> cpufreq driver. It would use the CPU clock multiplexer to switch to the
> intermediate clock source temporarily and then wait for the primary clock
> changing getting stable.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
