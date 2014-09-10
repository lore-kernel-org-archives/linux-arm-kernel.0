From: dianders@chromium.org (Doug Anderson)
Date: Tue, 9 Sep 2014 21:52:43 -0700
Subject: [PATCH v2 5/5] ARM: dts: Add Peach Pit and Pi dts entry for
 ISL29018 sensor
In-Reply-To: <1408533593-32346-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1408533593-32346-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408533593-32346-6-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=WdMx=7oLChYz-y2cY=MBpJmT7KXBq_hMV7FS16VT+85w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Wed, Aug 20, 2014 at 4:19 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> The Exynos5420 based Peach Pit and the Exynos5800 based Peach Pi
> machines have an i2c ISL29018 light sensor. This patch adds the
> device nodes needed to support this device.
>
> These DTS snippets were taken from the downstream Chrome OS 3.8
> kernel Device Tree for Peach Pit and Pi boards.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 6 ++++++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 6 ++++++
>  2 files changed, 12 insertions(+)

I would note that the downstream dts file has this i2c bus at 400kHz.
...but that's not a problem with your patch.  Perhaps you could submit
that as a separate patch?

Reviewed-by: Doug Anderson <dianders@chromium.org>
