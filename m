From: dianders@chromium.org (Doug Anderson)
Date: Thu, 24 Jul 2014 20:49:50 -0700
Subject: [PATCH v2 2/7] ARM: rockchip: clarify usability of
 DEBUG_RK3X_UART debug_ll options
In-Reply-To: <1722917.h37akzFaqW@diego>
References: <4868343.UFgjaXesOn@diego>
	<1722917.h37akzFaqW@diego>
Message-ID: <CAD=FV=XUgBkcO6J4gUaV+EV6hU0f+qgbUTZ5+y+9ostM7Z7Wzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Thu, Jul 17, 2014 at 5:19 PM, Heiko St?bner <heiko@sntech.de> wrote:
> The debug uart settings from the DEBUG_RK3X_UART options are usable on
> all Rockchip SoCs from the rk30xx and rk31xx series but not on the
> new rk3288 SoCs. Thus clarify their use to prevent confusion.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/Kconfig.debug | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks, this helps.

Reviewed-by: Doug Anderson <dianders@chromium.org>
