From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 15:12:54 -0800
Subject: [PATCH 3/3] clk: mvebu: armada-37xx-periph: add DVFS support for
 cpu clocks
In-Reply-To: <20171130134029.20751-4-gregory.clement@free-electrons.com>
References: <20171130134029.20751-1-gregory.clement@free-electrons.com>
 <20171130134029.20751-4-gregory.clement@free-electrons.com>
Message-ID: <20171221231254.GB7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30, Gregory CLEMENT wrote:
> When DVFS is enabled the CPU clock setting is done using an other set of
> registers.
> 
> These Power Management registers are exposed through a syscon as they
> will also be used by other drivers such as the cpufreq.
> 
> This patch add the possibility to modify the CPU frequency using the
> associate load level matching the target frequency. Then all the
> frequency switch is handle by the hardware.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---

Applied to clk-next + a small fix to regmap getting to make it
shorter.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
