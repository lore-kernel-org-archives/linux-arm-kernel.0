From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Jun 2015 14:27:25 -0700
Subject: [PATCH] clk: make several parent names const
In-Reply-To: <1432802751-6397-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1432802751-6397-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150604212725.GR676@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28, Uwe Kleine-K?nig wrote:
> Since commit 2893c379461a ("clk: make strings in parent name arrays
> const") the name of parent clocks can be const. So add more const in
> several clock drivers.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
