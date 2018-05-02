From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 02 May 2018 08:38:50 -0700
Subject: [PATCH v3 4/5] soc/tegra: pmc: Use of_clk_get_parent_count()
 instead of open coding
In-Reply-To: <1524063005-1716-5-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-5-git-send-email-geert+renesas@glider.be>
Message-ID: <152527553080.138124.1355023527391493631@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Geert Uytterhoeven (2018-04-18 07:50:04)
> As of_clk_get_parent_count() returns zero on failure, while
> of_count_phandle_with_args() might return a negative error code, this
> also fixes the issue of possibly using a very big number in the
> allocation below.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Applied to clk-next
