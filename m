From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 27 Nov 2017 14:37:10 +0100
Subject: [PATCH v4 1/4] clk: meson: gxbb: fix wrong clock for SARADC/SANA
In-Reply-To: <20171107141223.1507-1-yixun.lan@amlogic.com>
References: <20171107141223.1507-1-yixun.lan@amlogic.com>
Message-ID: <1511789830.30519.3.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-11-07 at 22:12 +0800, Yixun Lan wrote:
> According to the datasheet, in Meson-GXBB/GXL series,
> The clock gate bit for SARADC is HHI_GCLK_MPEG2 bit[22],
> while clock gate bit for SANA is HHI_GCLK_MPEG0 bit[10].
> 
> Test passed at gxl-s905x-p212 board.
> 
> The following published datasheets are wrong and should be updated
> [1] GXBB v1.1.4
> [2] GXL v0.3_20170314
> 
> Fixes: 738f66d3211d ("clk: gxbb: add AmLogic GXBB clk controller driver")
> Tested-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---

Applied fixes/drivers
Thanks
