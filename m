From: dianders@chromium.org (Doug Anderson)
Date: Wed, 21 Jan 2015 08:24:42 -0800
Subject: [PATCH] ARM: rockchip: remove cpu-core name from machine name
In-Reply-To: <1444639.mSKlrDUu2q@phil>
References: <1444639.mSKlrDUu2q@phil>
Message-ID: <CAD=FV=WX9H7VOyTbwH4APVsHLobfZ7GtC_rOuYJsfqVzfvXgtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Jan 21, 2015 at 1:49 AM, Heiko St?bner <heiko@sntech.de> wrote:
> The Rockchip support is not limited to Cortex-A9 socs anymore and its
> presence may confuse people reading /proc/cpuinfo. So remove the core
> specific part.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-rockchip/rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

FWIW for such a simple patch:

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
