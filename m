From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Aug 2015 12:57:26 -0700
Subject: [PATCH v1 1/2] clk: rockchip: add pclk_pd_pmu to the list of
 rk3288 critical clocks
In-Reply-To: <1438574211-4887-1-git-send-email-hl@rock-chips.com>
References: <1438574211-4887-1-git-send-email-hl@rock-chips.com>
Message-ID: <CAD=FV=VpYF7+Qkw3qiuQyU4n9k7aigf_on+t-kJcBQ_kHE7Nhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hl,

On Sun, Aug 2, 2015 at 8:56 PM, huang lin <hl@rock-chips.com> wrote:
> pclk_pd_pmu needs to keep running and with the upcoming gpio clock
> handling this is not always the case anymore. So add it to the list
> of critical clocks for now.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> Signed-off-by: huang lin <hl@rock-chips.com>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 1 +
>  1 file changed, 1 insertion(+)

Probably should get rid of the blank line between the two SoBs.
...and probably should fix your name to be capitalized?  ...but I
assume the maintainer can fix that when landing?  Otherwise:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
