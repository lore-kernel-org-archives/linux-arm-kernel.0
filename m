From: dianders@chromium.org (Doug Anderson)
Date: Tue, 4 Oct 2016 15:14:49 -0700
Subject: [PATCH v2 2/2] arm64: dts: rockchip: arch counter doesn't tick in
 system suspend
In-Reply-To: <1475604730-140264-2-git-send-email-briannorris@chromium.org>
References: <1475604730-140264-1-git-send-email-briannorris@chromium.org>
 <1475604730-140264-2-git-send-email-briannorris@chromium.org>
Message-ID: <CAD=FV=XGwc8k-OctcKmdJoFK44v86qegAAFDOpN71wpciA=3Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 4, 2016 at 11:12 AM, Brian Norris <briannorris@chromium.org> wrote:
> The "arm,no-tick-in-suspend" property was introduced to note
> implementations where the system counter does not quite follow the ARM
> specification that it "must be implemented in an always-on power
> domain".
>
> Particularly, RK3399's counter stops ticking when we switch from the
> 24MHz clock to the 32KHz clock in low-power suspend, so let's mark it as
> such.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2: new in v2
>
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
