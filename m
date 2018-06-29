From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 29 Jun 2018 10:18:48 -0700
Subject: [PATCH] clkdev: Remove duplicated negative index check from
 __of_clk_get()
In-Reply-To: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
References: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
Message-ID: <153029272800.143105.1065337298977850107@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Geert Uytterhoeven (2018-05-18 03:58:40)
> __of_clk_get() calls of_parse_phandle_with_args(), which rejects
> negative indices since commit bd69f73f2c81eed9 ("of: Create function for
> counting number of phandles in a property").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next
