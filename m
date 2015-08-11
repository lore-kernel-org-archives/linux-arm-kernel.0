From: dianders@chromium.org (Doug Anderson)
Date: Tue, 11 Aug 2015 15:52:36 -0700
Subject: [PATCH v5 1/2] clk: rockchip: add pclk_pd_pmu to the list of
 rk3288 critical clocks
In-Reply-To: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
References: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
Message-ID: <CAD=FV=Wm1NMqoGvCZ4pimB2d9gQEF9PJCCCdqdEBDa5Q=bHcCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 11, 2015 at 3:12 AM, Lin Huang <hl@rock-chips.com> wrote:
> From: Heiko Stuebner <heiko@sntech.de>
>
> pclk_pd_pmu needs to keep running and with the upcoming gpio clock
> handling this is not always the case anymore. So add it to the list
> of critical clocks for now.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v5:
> - Add From: Heiko Stuebner <heiko@sntech.de>
> - Add Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
>  drivers/clk/rockchip/clk-rk3288.c | 1 +
>  1 file changed, 1 insertion(+)

You forgot to carry forward my reviewed by:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
