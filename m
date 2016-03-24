From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 24 Mar 2016 19:15:28 +0100
Subject: [PATCH v2 3/4] ARM64: dts: amlogic: add Hardkernel ODROID-C2
In-Reply-To: <1458842715-27066-4-git-send-email-khilman@baylibre.com>
References: <1458842715-27066-1-git-send-email-khilman@baylibre.com>
 <1458842715-27066-4-git-send-email-khilman@baylibre.com>
Message-ID: <56F42EC0.1090307@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.03.2016 um 19:05 schrieb Kevin Hilman:
> Add minimal DT files for the Hardkernel ODROID-C2 board based on the
> Amlogic S905/GXBB SoC.
> 
> Used the other gxbb boards from Andreas F?rber as a starting point.
> 
> Cc: Andreas F?rber <afaerber@suse.de>
> Cc: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile               |  1 +
>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 69 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Will re-test at a later point.

Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
