From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 14 Sep 2015 12:49:54 -0700
Subject: [PATCH] clk: rockchip: add critical clock for rk3368
In-Reply-To: <5267432.TORlj1Iv40@diego>
References: <5267432.TORlj1Iv40@diego>
Message-ID: <20150914194954.GA21561@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13, Heiko St?bner wrote:
> Again a result of the gpio-clock-liberation the rk3368 needs the
> pclk_pd_pmu marked as critical, to boot successfully.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
