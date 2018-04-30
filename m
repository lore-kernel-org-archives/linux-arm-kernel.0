From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Apr 2018 15:41:05 +0200
Subject: [PATCH v3 3/5] soc: rockchip: power-domain: Use
 of_clk_get_parent_count() instead of open coding
In-Reply-To: <1524063005-1716-4-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
 <1524063005-1716-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20180430134105.GD11457@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 04:50:03PM +0200, Geert Uytterhoeven wrote:
> As of_clk_get_parent_count() returns zero on failure, while
> of_count_phandle_with_args() might return a negative error code, this
> also fixes the issue of possibly using a negative number in the
> allocation below.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
