From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jun 2016 17:44:38 -0700
Subject: [PATCH] clk: at91: make of_sama5d2_clk_generated_setup() static
In-Reply-To: <1465317489-14920-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465317489-14920-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160621004438.GG1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07, Ben Dooks wrote:
> The of_sama5d2_clk_generated_setup() is not exported outside
> of the driver, so make it static to fix the warning about it
> being not static:
> 
> drivers/clk/at91/clk-generated.c:270:13: warning: symbol 'of_sama5d2_clk_generated_setup' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
