From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Apr 2018 15:17:56 +0200
Subject: [PATCH v2 3/5] soc: rockchip: power-domain: Use
 of_clk_get_parent_count() instead of open coding
In-Reply-To: <1523364701-15383-4-git-send-email-geert+renesas@glider.be>
References: <1523364701-15383-1-git-send-email-geert+renesas@glider.be>
 <1523364701-15383-4-git-send-email-geert+renesas@glider.be>
Message-ID: <7442109.yKeQIlf4qX@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 10. April 2018, 14:51:39 CEST schrieb Geert Uytterhoeven:
> As of_clk_get_parent_count() returns zero on failure, while
> of_count_phandle_with_args() might return a negative error code, this
> also fixes the issue of possibly using a negative number in the
> allocation below.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Depending on how we plan on merging this series, I could either pick
this patch for 4.19, after patch1 makes it into 4.18 or otherwise
someone could pick the whole series together with my

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

for this patch.


Heiko
