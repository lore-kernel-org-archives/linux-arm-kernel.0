From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:30:00 -0800
Subject: [PATCH] clk: uniphier: continue probing even if some clocks fail
 to register
In-Reply-To: <1484742679-8373-1-git-send-email-yamada.masahiro@socionext.com>
References: <1484742679-8373-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170121003000.GR20800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18, Masahiro Yamada wrote:
> Do not let the entire probe function fail even if some clocks fail
> to register.  Let's continue with succeeded clocks.  This will give
> the system more chances to boot and allow us to investigate the
> cause of the failure.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
