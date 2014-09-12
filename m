From: dianders@chromium.org (Doug Anderson)
Date: Fri, 12 Sep 2014 16:46:36 -0700
Subject: [PATCH v2 2/7] clk: rockchip: fix rk3288 pll status register
 location
In-Reply-To: <1410561030-19127-3-git-send-email-heiko@sntech.de>
References: <1410561030-19127-1-git-send-email-heiko@sntech.de>
 <1410561030-19127-3-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=Uu1z+zbKjW5gPtTpDRh5=WXpBcnuwc7GuUKvKTG0sNZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Sep 12, 2014 at 3:30 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> From: Jianqun <jay.xu@rock-chips.com>
>
> In RK3288, APLL lock status bit is in GRF_SOC_STATUS1,
> but in RK3188, is GRFSOC_STATUS0.
>
> Signed-off-by: Jianqun <jay.xu@rock-chips.com>
>
> Also name the constant accordingly as GRF_SOC_STATUS1
> to prevent confusion.
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
