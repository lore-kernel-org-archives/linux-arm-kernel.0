From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 06 Jan 2017 20:32:02 +0100
Subject: [PATCH] clk: rockchip: Remove useless init of "grf" to
 -EPROBE_DEFER
In-Reply-To: <20170106163101.32048-1-dianders@chromium.org>
References: <20170106163101.32048-1-dianders@chromium.org>
Message-ID: <3165407.VSLAtN8Q2L@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 6. Januar 2017, 08:31:01 CET schrieb Douglas Anderson:
> When we used to defer setting the "grf" member to
> rockchip_clk_get_grf() it was important to init the "grf" member to an
> error value in rockchip_clk_init().  With recent changes, we now set
> "grf" right in rockchip_clk_init() (two lines below the place where we
> initted it).  That makes the old init useless.  Get rid of it.
> 
> Fixes: 6f339dc2719e ("clk: rockchip: lookup General Register Files in
> rockchip_clk_init") Signed-off-by: Douglas Anderson <dianders@chromium.org>

thanks for the catch, applied for 4.11


Thanks
Heiko
