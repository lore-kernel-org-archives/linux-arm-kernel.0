From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 15:35:30 -0700
Subject: [PATCH] clk: mvebu: armada-37xx-periph: Fix the clock gate flag
In-Reply-To: <20160930083359.14943-1-gregory.clement@free-electrons.com>
References: <20160930083359.14943-1-gregory.clement@free-electrons.com>
Message-ID: <20161017223530.GL8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30, Gregory CLEMENT wrote:
> For the gate part of the peripheral clock setting the bit disables the
> clock and clearing it enables the clock. This is not the default behavior
> of clk_gate component, so we need to use the CLK_GATE_SET_TO_DISABLE flag.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
