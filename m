From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 3 Jul 2016 17:57:00 +0200
Subject: [PATCH] ARM64: dts: amlogic: Add basic support for Amlogic S905X
In-Reply-To: <1467399478-7183-1-git-send-email-carlo@caione.org>
References: <1467399478-7183-1-git-send-email-carlo@caione.org>
Message-ID: <577935CC.80001@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.07.2016 um 20:57 schrieb Carlo Caione:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This patch introduces the basic support for the Amlogic S905X (Meson
> GXL) and for the Amlogic evaluation board P212.
> No documentation has been released yet for this SoC, so for now only the
> bare minimum has been added in the DT.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt |   5 +
>  arch/arm64/boot/dts/amlogic/Makefile              |   1 +
>  arch/arm64/boot/dts/amlogic/meson-gxl-p212.dts    |  70 +++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi        | 179 ++++++++++++++++++++++
>  4 files changed, 255 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-p212.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi

I don't have documentation either, but looks sane to me.

Reviewed-by: Andreas F?rber <afaerber@suse.de>

With the recent driver progress have you checked whether /memory at 0
actually works or whether U-Boot gives us a /memory node that Linux is
using instead?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
