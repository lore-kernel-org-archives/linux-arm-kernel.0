From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Nov 2016 17:37:50 -0700
Subject: [PATCH v4 1/1] clk: mvebu: migrate CP110 system controller to
 clk_hw API and registration
In-Reply-To: <1474789673-3837-2-git-send-email-mw@semihalf.com>
References: <1474789673-3837-1-git-send-email-mw@semihalf.com>
 <1474789673-3837-2-git-send-email-mw@semihalf.com>
Message-ID: <20161102003750.GL16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25, Marcin Wojtas wrote:
> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in Armada
> CP110 system controller driver. This commit introduces new
> API and registration for all clocks in CP110 HW blocks.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
