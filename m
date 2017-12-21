From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 15:12:42 -0800
Subject: [PATCH 2/3] clk: mvebu: armada-37xx-periph: prepare cpu clk to
 be used with DVFS
In-Reply-To: <20171130134029.20751-3-gregory.clement@free-electrons.com>
References: <20171130134029.20751-1-gregory.clement@free-electrons.com>
 <20171130134029.20751-3-gregory.clement@free-electrons.com>
Message-ID: <20171221231242.GA7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30, Gregory CLEMENT wrote:
> When DVFS will be enabled then the cpu clk will use a different set of
> register at run time. That means that we won't be able to use the common
> callback and need to use our own ones.
> 
> This patch prepares this change by switching on our own set of callbacks
> without modifying the behavior of the clocks.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
