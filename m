From: dianders@chromium.org (Doug Anderson)
Date: Fri, 10 Oct 2014 09:53:08 -0700
Subject: [PATCH v2 1/2] clk: rockchip: add 400MHz and 500MHz for rk3288
 clock rate
In-Reply-To: <1412916630-8256-2-git-send-email-kever.yang@rock-chips.com>
References: <1412916630-8256-1-git-send-email-kever.yang@rock-chips.com>
 <1412916630-8256-2-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=XHrOvgtF9eAibgdOiwOT6dztAh7xCmWzbhRC-dFQmEZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever

On Thu, Oct 9, 2014 at 9:50 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> This patch add 400MHz and 500MHz to clock rate table for rk3288.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
> Changes in v2:
> - change the PLL setting of 400M to meet the constraints of TRM
>
>  drivers/clk/rockchip/clk-rk3288.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks!  These numbers for 400MHz look better.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
