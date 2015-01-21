From: dianders@chromium.org (Doug Anderson)
Date: Wed, 21 Jan 2015 15:28:54 -0800
Subject: [PATCH 1/3] clk: rockchip: add id for watchdog pclk on rk3288
In-Reply-To: <3744380.nyzH2eD44r@phil>
References: <1736604.toH3biuFW2@phil>
	<3744380.nyzH2eD44r@phil>
Message-ID: <CAD=FV=WrDwBF78twN7fSLxf2n8jBTbZ2obTXWttrAnzeBn4b2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Jan 21, 2015 at 11:55 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Adds a new id for the pclk supplying the watchdog on rk3288 socs.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  include/dt-bindings/clock/rk3288-cru.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
