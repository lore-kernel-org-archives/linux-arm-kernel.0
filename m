From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 12:20:38 -0700
Subject: [PATCH] clkdev: Remove duplicated negative index check from
 __of_clk_get()
In-Reply-To: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
References: <1526641120-1585-1-git-send-email-geert+renesas@glider.be>
Message-ID: <152788083877.225090.16757573144833344500@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Geert Uytterhoeven (2018-05-18 03:58:40)
> __of_clk_get() calls of_parse_phandle_with_args(), which rejects
> negative indices since commit bd69f73f2c81eed9 ("of: Create function for
> counting number of phandles in a property").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Commit bd69f73f2c81eed9 is in v3.9.

Did you send this to Russell's patch tracker? Otherwise I can pick it up
to clk-next.
