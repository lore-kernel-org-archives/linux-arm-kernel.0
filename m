From: briannorris@chromium.org (Brian Norris)
Date: Wed, 2 Dec 2015 10:26:23 -0800
Subject: [PATCH 2/3] ARM: dts: rockchip: add veyron-brain board
In-Reply-To: <6340149.qAGjxgRvNd@diego>
References: <2767415.mEkgRbSSUB@diego>
 <6340149.qAGjxgRvNd@diego>
Message-ID: <20151202182623.GA49625@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 06:16:02PM +0100, Heiko St?bner wrote:
> Similar to pinky, brain is a development model and probably also
> nearing extinction. But to keep pinky from being lonely I'll keep
> the two brain boards around as well, especially as they as well
> have easily accessible dut-connectors.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
> ---
> would cool to get an Ack from ChromeOS-people concerning the
> license change to GPL2/X11 - as with the dts before

For the license changes:

Acked-by: Brian Norris <briannorris@chromium.org>

Not tested or reviewed otherwise.

>  Documentation/devicetree/bindings/arm/rockchip.txt |   5 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/rk3288-veyron-brain.dts          | 139 +++++++++++++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-veyron-brain.dts

...

Brian
