From: dianders@chromium.org (Doug Anderson)
Date: Fri, 13 May 2016 15:53:14 -0700
Subject: [PATCH v4 1/3] ARM64: dts: rockchip: make rk3399's grf a
 "simple-mfd"
In-Reply-To: <1463177524-113856-1-git-send-email-briannorris@chromium.org>
References: <1463177524-113856-1-git-send-email-briannorris@chromium.org>
Message-ID: <CAD=FV=UGbNsneP_Vm_YYOrjWYn=zVKB5pZYvOOJczKAuRztCkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 13, 2016 at 3:12 PM, Brian Norris <briannorris@chromium.org> wrote:
> Per the examples in
> Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt, we need the
> grf node to be a simple-mfd in order to properly enumerate child devices
> like our eMMC PHY.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v4:
>
>  * New, split out of patch 2, per Heiko's recommendation
>
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
