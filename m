From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 19 Jan 2015 18:26:57 +0100
Subject: [PATCH v3 7/7] ARM: dts: exynos5250: add display power domain
In-Reply-To: <1421243091-10778-8-git-send-email-m.szyprowski@samsung.com>
References: <1421243091-10778-1-git-send-email-m.szyprowski@samsung.com>
 <1421243091-10778-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CABxcv=m7Q5v3wH1FU9S0E-dMgebZ_+M_dLELr39h7_VA0Oc8cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marek and Andrzej,

On Wed, Jan 14, 2015 at 2:44 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> From: Andrzej Hajda <a.hajda@samsung.com>
>
> The patch adds domain definition and references to it in appropriate devices.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> [mszyprow: rebased onto generic power domains dt bindings]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

This patch makes HDMI to work on my Exynos5250 Snow Chromebook:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
