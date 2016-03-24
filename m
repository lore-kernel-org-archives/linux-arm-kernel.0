From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 24 Mar 2016 19:19:53 +0100
Subject: [PATCH v2 4/4] ARM64: dts: amlogic: Add P200/P201 boards
In-Reply-To: <1458842715-27066-5-git-send-email-khilman@baylibre.com>
References: <1458842715-27066-1-git-send-email-khilman@baylibre.com>
 <1458842715-27066-5-git-send-email-khilman@baylibre.com>
Message-ID: <56F42FC9.1000905@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.03.2016 um 19:05 schrieb Kevin Hilman:
> Add minimal DT files for the Amlogic P20x development boards, based on
> the Amlogic S905/GXBB SoC.
> 
> Cc: Andreas F?rber <afaerber@suse.de>
> Cc: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile             |  2 +
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts  | 52 +++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts  | 52 +++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 65 ++++++++++++++++++++++++
>  4 files changed, 171 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
