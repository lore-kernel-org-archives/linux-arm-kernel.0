From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 02 May 2018 08:38:46 -0700
Subject: [PATCH v3 3/5] soc: rockchip: power-domain: Use
 of_clk_get_parent_count() instead of open coding
In-Reply-To: <1524063005-1716-4-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-4-git-send-email-geert+renesas@glider.be>
Message-ID: <152527552692.138124.9472680209483820124@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Geert Uytterhoeven (2018-04-18 07:50:03)
> As of_clk_get_parent_count() returns zero on failure, while
> of_count_phandle_with_args() might return a negative error code, this
> also fixes the issue of possibly using a negative number in the
> allocation below.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---

Applied to clk-next
