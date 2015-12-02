From: briannorris@chromium.org (Brian Norris)
Date: Wed, 2 Dec 2015 10:31:08 -0800
Subject: [PATCH 3/3] ARM: dts: rockchip: add veyron-minnie board
In-Reply-To: <2008536.lEUHWtryIT@diego>
References: <2767415.mEkgRbSSUB@diego>
 <2008536.lEUHWtryIT@diego>
Message-ID: <20151202183108.GB49625@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 06:16:55PM +0100, Heiko St?bner wrote:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> Also known as the Asus Chromebit.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
> ---
> would cool to get an Ack from ChromeOS-people concerning the
> license change to GPL2/X11 - as with the dts before

For the license change:

Acked-by: Brian Norris <briannorris@chromium.org>

> Also if someone else should be designated as author I would be happy
> got get a shout about that :-) . I did take Chris as he was the one
> submitting the initial mickey dts to the chromeos tree.

Looks OK to me, FWIW.

> And of course it would be cool if anyone could test that on an actual
> mickey device.

Sorry, didn't test!

>  Documentation/devicetree/bindings/arm/rockchip.txt |   9 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/rk3288-veyron-mickey.dts         | 246 +++++++++++++++++++++
>  3 files changed, 256 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-veyron-mickey.dts

...

Brian
