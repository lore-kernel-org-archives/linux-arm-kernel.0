From: dianders@chromium.org (Doug Anderson)
Date: Fri, 13 May 2016 15:54:35 -0700
Subject: [PATCH v4 3/3] ARM64: dts: rockchip: enable eMMC for rk3399 EVB
In-Reply-To: <1463177524-113856-3-git-send-email-briannorris@chromium.org>
References: <1463177524-113856-1-git-send-email-briannorris@chromium.org>
 <1463177524-113856-3-git-send-email-briannorris@chromium.org>
Message-ID: <CAD=FV=VffvTEVyCpVn20rRsGRYKPVy_6qjTBoiOvMX4EjeWFrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 13, 2016 at 3:12 PM, Brian Norris <briannorris@chromium.org> wrote:
> Rockchip's rk3399 evaluation board has eMMC. Let's enable the
> newly-added nodes.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v4:
>
>  * alphabetize &node references
>
> v3:
>
>  * no change
>
> v2:
>
>  * better commit description
>
>  arch/arm64/boot/dts/rockchip/rk3399-evb.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
