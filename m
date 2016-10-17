From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 15:30:58 -0700
Subject: [PATCH] clk: mvebu: armada-37xx-periph: Fix the clock provider
 registration
In-Reply-To: <20160929142855.30408-1-gregory.clement@free-electrons.com>
References: <20160929142855.30408-1-gregory.clement@free-electrons.com>
Message-ID: <20161017223058.GJ8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29, Gregory CLEMENT wrote:
> While trying using a peripheral clock on a driver, I saw that the clock
> pointer returned by the provider was NULL.
> 
> The problem was a missing indirection. It was the pointer stored in the
> hws array which needed to be updated not the value it contains.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
