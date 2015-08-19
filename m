From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 20 Aug 2015 01:36:46 +0200
Subject: [PATCH v2 3/3] ARM: dts: rockchip: correct regulator power states
 for suspend
In-Reply-To: <1440022721-73712-3-git-send-email-briannorris@chromium.org>
References: <1440022721-73712-1-git-send-email-briannorris@chromium.org>
 <1440022721-73712-3-git-send-email-briannorris@chromium.org>
Message-ID: <CABxcv=mpz7yJFiR=1NQxsbmbVCVGYpgZYS1rEWi58aSUQaELcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Brian,

On Thu, Aug 20, 2015 at 12:18 AM, Brian Norris <briannorris@chromium.org> wrote:
> When getting translated from a downstream device tree that used slightly
> different DT bindings, these regulators got labeled with the
> "on-in-suspend" state, when they were actually supposed to be turned off
> for S3 suspend. This was harmless, but not intentional, AFAICT.
>
> Let's turn them off to get the optimal power state.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> ---
> New in v2. Tested jaq.
>
>  arch/arm/boot/dts/rk3288-veyron-jerry.dts  | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-pinky.dts  | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
