From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Jun 2017 10:48:41 -0700
Subject: [PATCH] clk: uniphier: provide NAND controller clock rate
In-Reply-To: <1497971163-9206-1-git-send-email-yamada.masahiro@socionext.com>
References: <1497971163-9206-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170621174841.GD4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21, Masahiro Yamada wrote:
> This allows the NAND driver to get the clock rate via clk_get_rate().
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
