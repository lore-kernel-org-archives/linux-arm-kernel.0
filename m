From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 25 Jul 2018 16:23:07 -0700
Subject: [PATCH 2/2] clk: uniphier: add more USB3 PHY clocks
In-Reply-To: <1532075856-1723-2-git-send-email-yamada.masahiro@socionext.com>
References: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
 <1532075856-1723-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <153256098739.48062.2834824594130786288@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Masahiro Yamada (2018-07-20 01:37:36)
> Add USB3 PHY clocks where missing.  Use fixed-factor clocks for those
> without gating.
> 
> For clarification, prefix clock names with 'ss' or 'hs'.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next
