From: dianders@chromium.org (Doug Anderson)
Date: Mon, 23 May 2016 13:47:20 -0700
Subject: [PATCH 3/3] ARM: rockchip: drop rk3288 jtag/mmc switch handling
In-Reply-To: <1464015539-19521-4-git-send-email-heiko@sntech.de>
References: <1464015539-19521-1-git-send-email-heiko@sntech.de>
 <1464015539-19521-4-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=UC1uL9SeF5ZWKBO+b1AJJLCB91nTt1bi92ysEt9Nhekw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Mon, May 23, 2016 at 7:58 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> We moved that functionality to a more generic place where it can also
> be used for other socs, so drop it from architecture code.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-rockchip/rockchip.c | 12 ------------
>  1 file changed, 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
