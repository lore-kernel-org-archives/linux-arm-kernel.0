From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 10:54:56 -0800
Subject: [PATCH] clk: at91: Revert "keep slow clk enabled to prevent
 system hang"
In-Reply-To: <1447759593-20816-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1447759593-20816-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20151120185456.GV32672@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17, Alexandre Belloni wrote:
> Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> hang") added a workaround for the slow clock as it is not properly handled
> by its users.
> 
> Now that the slow clock is taken properly by the drivers, this workaround
> is not necessary anymore, revert it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Michael Turquette <mturquette@baylibre.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
