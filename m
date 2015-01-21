From: dianders@chromium.org (Doug Anderson)
Date: Wed, 21 Jan 2015 15:30:52 -0800
Subject: [PATCH 3/3] ARM: dts: rockchip: add rk3288 watchdog clock
In-Reply-To: <9945765.pgmzY3SFjQ@phil>
References: <1736604.toH3biuFW2@phil>
	<9945765.pgmzY3SFjQ@phil>
Message-ID: <CAD=FV=Wg0zv61p2FU1uNXQAdWwSQ+xEmoW6QTpWTqArus3fYHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Jan 21, 2015 at 11:56 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Add the clock property for the watchdog on rk3288 socs.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>

On rk3288 on a 3.14 kernel with backports:

Tested-by: Doug Anderson <dianders@chromium.org>
