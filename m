From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 24 Mar 2016 17:55:34 +0100
Subject: [PATCH 1/3] Documentation: devicetree: amlogic: Document P20x and
 ODROID-C2 boards
In-Reply-To: <1458758013-11890-1-git-send-email-khilman@baylibre.com>
References: <1458758013-11890-1-git-send-email-khilman@baylibre.com>
Message-ID: <56F41C06.40207@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.03.2016 um 19:33 schrieb Kevin Hilman:
> Add compatible strings for Amlogic S905/GXBB based boards: Hardkernel
> ODROID-C2, Amlogic P200 and Amlogic P201.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
> index 8a5122ab19b0..fcc6f6c10803 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.txt
> +++ b/Documentation/devicetree/bindings/arm/amlogic.txt
> @@ -25,3 +25,6 @@ Board compatible values:
>    - "tronsmart,vega-s95-pro", "tronsmart,vega-s95" (Meson gxbb)
>    - "tronsmart,vega-s95-meta", "tronsmart,vega-s95" (Meson gxbb)
>    - "tronsmart,vega-s95-telos", "tronsmart,vega-s95" (Meson gxbb)
> +  - "hardkernel,odroid-c2" (Meson gxbb)
> +  - "amlogic,p200" (Meson gxbb)
> +  - "amlogic,p201" (Meson gxbb)

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
