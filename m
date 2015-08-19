From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 20 Aug 2015 01:35:41 +0200
Subject: [PATCH v2 2/3] ARM: dts: rockchip: correct regulator PM properties
In-Reply-To: <1440022721-73712-2-git-send-email-briannorris@chromium.org>
References: <1440022721-73712-1-git-send-email-briannorris@chromium.org>
 <1440022721-73712-2-git-send-email-briannorris@chromium.org>
Message-ID: <CABxcv=kV2YW7gTmvaLTQiQUbmfVcqttV8prRfm0zxV=hvsRe9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Brian,

On Thu, Aug 20, 2015 at 12:18 AM, Brian Norris <briannorris@chromium.org> wrote:
> This DTS file was submitted with non-upstream bindings. I happened
> across this while reviewing the jaq DTS.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> ---
> Did not test minnie
>
> v1 -> v2:
>  - use "off-in-suspend", as that's the equivalent to the downstream
>    'regulator-suspend-mem-disabled'
>
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

Patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
