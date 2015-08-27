From: dianders@chromium.org (Doug Anderson)
Date: Thu, 27 Aug 2015 15:07:30 -0700
Subject: [PATCH v3] ARM: dts: rockchip: add veyron-jaq board
In-Reply-To: <1440457083-77519-1-git-send-email-briannorris@chromium.org>
References: <1440457083-77519-1-git-send-email-briannorris@chromium.org>
Message-ID: <CAD=FV=W34EXSvfJCRjaTy7jE-EnjMyechY2EcXn13G6HOfsh1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian,

On Mon, Aug 24, 2015 at 3:58 PM, Brian Norris <briannorris@chromium.org> wrote:
> a.k.a. Haier Chromebook 11, and others
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> v2 -> v3:
>  - add "and others" language
>  - drop other patches from series (picked up already by Heiko)
>
> v1 -> v2:
>  - add overlooked DT binding doc
>  - fixup regulator suspend state for LDO_REG2
>
>
>  Documentation/devicetree/bindings/arm/rockchip.txt |   7 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts            | 176 +++++++++++++++++++++
>  3 files changed, 184 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
