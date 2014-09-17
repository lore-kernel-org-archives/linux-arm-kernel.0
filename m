From: dianders@chromium.org (Doug Anderson)
Date: Wed, 17 Sep 2014 08:24:03 -0700
Subject: [PATCH 1/2] ARM: dts: Add rtc_src clk for s3c-rtc on exynos Peach
 boards
In-Reply-To: <1410954633-27025-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1410954633-27025-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410954633-27025-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=WctxZpkun4z8yZ89GrKoMZvvzcEPSLa9nrxEmjh_W1uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Wed, Sep 17, 2014 at 4:50 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> commit 546b117fdf17 ("rtc: s3c: add support for RTC of Exynos3250 SoC")
> added an "rtc_src" DT property for the Samsung's S3C Real Time Clock
> controller that specifies the 32.768 kHz clock that uses the RTC as its
> source clock. In the case of the Peach Pit and Pi machines, the Maxim
> 77802 32kHz AP clock is used as the source clock.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 5 ++++-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
