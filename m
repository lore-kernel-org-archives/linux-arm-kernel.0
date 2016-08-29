From: carlo@caione.org (Carlo Caione)
Date: Mon, 29 Aug 2016 10:01:46 +0200
Subject: [RFC PATCH 0/3] ARm64: amlogic: Introduce common GX family dtsi
In-Reply-To: <1472457371-1305-1-git-send-email-narmstrong@baylibre.com>
References: <1472457371-1305-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAOQ7t2YGbASh7v25wgDspKNWgFOcRsikJs_WZptn+LkVXmaHig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 9:56 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> The new Amlogic GLX SoCs (S905X and S905D) are part of the Meson GX family so
> they share some basic characteritics that can be described in a common GX
> dtsi file used by the Meson GXBB and Meson GXL dtsi.
>
> This patchset introduces the common dtsi and switches the GLX and GXBB to use
> the common dtsi, the GXBB dtsi is reformated to handle this situation.
>
> This patchset depends on Carlo Caione "ARM64: dts: amlogic: Add basic support for Amlogic S905X" [1]
>
> [1] http://lkml.kernel.org/r/1472382113-10754-1-git-send-email-carlo at caione.org
>
> Neil Armstrong (3):
>   ARM64: dts: amlogic: Add Meson GX Family common dtsi
>   ARM64: dts: amlogic: Switch Meson GXL dtsi to use common GX dtsi
>   ARM64: dts: amlogic: Switch Meson GXBB dtsi to use common GX dtsi

FWIW
Acked-by: Carlo Caione <carlo@endlessm.com>

-- 
Carlo Caione
