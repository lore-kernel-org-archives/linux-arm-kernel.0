From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Nov 2017 10:04:42 -0800
Subject: [PATCH] clk: uniphier: fix DAPLL2 clock rate of Pro5
In-Reply-To: <1507170779-26688-1-git-send-email-yamada.masahiro@socionext.com>
References: <1507170779-26688-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20171114180442.GB11955@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05, Masahiro Yamada wrote:
> The parent of DAPLL2 should be DAPLL1.  Fix the clock connection.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
