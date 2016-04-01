From: dianders@chromium.org (Doug Anderson)
Date: Thu, 31 Mar 2016 17:53:02 -0700
Subject: [PATCH] ARM: dts: rockchip: update rk3288-veyron cpu operating
 points
In-Reply-To: <1459459483-5356-1-git-send-email-heiko@sntech.de>
References: <1459459483-5356-1-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=XHFvHuxogFfVk5z5f8T9f1LOysPQKKK7y+EiGmvtYDRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko

On Thu, Mar 31, 2016 at 2:24 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> The generic operating points specified in rk3288.dtsi are specified by
> Rockchip as conservative and for all cases.
>
> In contrast the Veyron ChromeOS devices are supposed to use a special
> chip variant often called rk3288-c and use different operating points
> in their kernel also including a higher max frequency.
>
> So override the operating points for veyron devices.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Matches the Chrome OS tree.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
