From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 05 Sep 2016 12:53:00 +0200
Subject: [PATCH v4 4/5] net: stmmac: add a glue driver for the Amlogic
 Meson 8b / GXBB DWMAC
In-Reply-To: <201609050953.67GKeUAU%fengguang.wu@intel.com>
References: <201609050953.67GKeUAU%fengguang.wu@intel.com>
Message-ID: <14789887.lyko4Om94p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 5, 2016 9:37:29 AM CEST kbuild test robot wrote:
> All error/warnings (new ones prefixed by >>):
> 
> >> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:63:18: error: field 'm250_mux' has incomplete type
>      struct clk_mux  m250_mux;
>                      ^
> >> drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c:67:21: error: field 'm250_div' has incomplete type
>      struct clk_divider m250_div;
>                         ^
> 

I think this needs a compile-time dependency on COMMON_CLK

	Arnd
