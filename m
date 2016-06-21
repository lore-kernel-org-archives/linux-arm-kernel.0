From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jun 2016 17:45:01 -0700
Subject: [PATCH] clk: iproc: fix missing include of clk-iproc.h
In-Reply-To: <1465317150-12704-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465317150-12704-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160621004501.GH1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07, Ben Dooks wrote:
> Fix the implicit declaration of iproc_armpll_setup() by
> including clk-iproc.h which defines it. Fixes the warning:
> 
> drivers/clk/bcm/clk-iproc-armpll.c:242:13: warning: symbol 'iproc_armpll_setup' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
