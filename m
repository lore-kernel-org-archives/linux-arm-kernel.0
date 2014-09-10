From: dianders@chromium.org (Doug Anderson)
Date: Tue, 9 Sep 2014 21:48:56 -0700
Subject: [PATCH v2 4/5] ARM: dts: Add thermistor dts fragment used by
 exynos based Peach boards
In-Reply-To: <1408533593-32346-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1408533593-32346-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408533593-32346-5-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=VMRHoNs3wDGRi4snwowc8F6xAD27uv57r51Rd7hEEeOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier / Naveen,

On Wed, Aug 20, 2014 at 4:19 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>
> This patch creates a thermistor fragment carrying the NTC Thermistor
> nodes as children of the IIO based ADC.
>
> This fragment is included in exynos5420-peach-pit.dts and
> exynos5800-peach-pi.dts.
>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/cros-adc-thermistors.dtsi | 44 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5420-peach-pit.dts  |  6 ++++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts   |  6 ++++
>  3 files changed, 56 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
