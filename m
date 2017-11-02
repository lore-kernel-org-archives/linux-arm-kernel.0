From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 1 Nov 2017 22:55:52 -0700
Subject: [PATCH v2] clk: sunxi: fix build warning
In-Reply-To: <20171024170616.24889-1-clabbe.montjoie@gmail.com>
References: <20171024170616.24889-1-clabbe.montjoie@gmail.com>
Message-ID: <20171102055552.GQ30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24, Corentin Labbe wrote:
> This patch fix the following build warning:
> drivers/clk/sunxi/clk-factors.c:279:14: warning: variable 'name' set but not used [-Wunused-but-set-variable]
> 
> Fixes: 4cbeaebb8af1 ("clk: sunxi: factors: Add unregister function")
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
