From: dianders@chromium.org (Doug Anderson)
Date: Wed, 10 Sep 2014 13:02:02 -0700
Subject: [PATCH v3 6/7] ARM: dts: Set i2c7 clock at 400kHz for Peach boards
In-Reply-To: <1410344391-5675-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1410344391-5675-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410344391-5675-7-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=Wb+0gQ7xLzxoXz_7gxEK01oX3fm8wcBwqM2tzUvQ8h-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Wed, Sep 10, 2014 at 3:19 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> The downstream ChromeOS 3.8 kernel sets the clock frequency
> for the I2C bus 7 at 400kHz. Do the same change in mainline.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 1 +
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
