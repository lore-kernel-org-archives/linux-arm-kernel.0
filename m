From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 25 Jul 2018 16:23:04 -0700
Subject: [PATCH 1/2] clk: uniphier: add NAND 200MHz clock
In-Reply-To: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <153256098433.48062.7081577175619627994@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Masahiro Yamada (2018-07-20 01:37:35)
> The Denali NAND controller IP needs three clocks:
> 
>  - clk: controller core clock
> 
>  - clk_x: bus interface clock
> 
>  - ecc_clk: clock at which ECC circuitry is run
> 
> Currently, only the first one (50MHz) is provided.  The rest of the
> two clock ports must be connected to the 200MHz clock line.  Add this.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next
