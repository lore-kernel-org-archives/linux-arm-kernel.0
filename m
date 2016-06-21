From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jun 2016 17:46:24 -0700
Subject: [PATCH] clk: hi6220: fix missing clk.h include
In-Reply-To: <1465307648-15660-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465307648-15660-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160621004624.GI1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07, Ben Dooks wrote:
> Fix the warning from missing "clk.h" include which
> defines hi6220_register_clkdiv() function.
> 
> drivers/clk/hisilicon/clkdivider-hi6220.c:102:12: warning: symbol 'hi6220_register_clkdiv' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
