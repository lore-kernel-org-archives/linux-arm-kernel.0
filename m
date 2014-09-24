From: dianders@chromium.org (Doug Anderson)
Date: Wed, 24 Sep 2014 10:57:20 -0700
Subject: [PATCH v2 2/3] clk: rockchip: use the clock id for nodes init
In-Reply-To: <1411572802-22042-3-git-send-email-kever.yang@rock-chips.com>
References: <1411572802-22042-1-git-send-email-kever.yang@rock-chips.com>
 <1411572802-22042-3-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=X1A6zKsGzctS6_Ve_zuNRW6_5kyawPEK1VeBJTimXTwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Wed, Sep 24, 2014 at 8:33 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
> This patch use the new defined clock ID to initial the clock nodes.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
>
> Changes in v2:
> - split into two patches of add clock node in PD_VIDEO and
>   use new defined clock ID
>
>  drivers/clk/rockchip/clk-rk3288.c | 68 +++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 34 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
