From: robherring2@gmail.com (Rob Herring)
Date: Wed, 4 Feb 2015 10:02:53 -0600
Subject: [PATCH RFC v8 02/21] of: Add vendor prefix for Himax Technologies
 Inc.
In-Reply-To: <1420014219-915-3-git-send-email-Ying.Liu@freescale.com>
References: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
 <1420014219-915-3-git-send-email-Ying.Liu@freescale.com>
Message-ID: <CAL_JsqJQuVSBQ73v45GEy+-OR74iZ+AT-R8vaExqJfpSMupAWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 31, 2014 at 2:23 AM, Liu Ying <Ying.Liu@freescale.com> wrote:
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>

I don't know what the status is for the rest of the series, but I'm
applying this and patch 3 so you don't have to keep sending them.

Rob

> ---
> v7->v8:
>  * None.
>
> v6->v7:
>  * None.
>
> v5->v6:
>  * None.
>
> v4->v5:
>  * None.
>
> v3->v4:
>  * Fix an ordering issue to address Stefan Wahren's comment.
>
> v2->v3:
>  * None.
>
> v1->v2:
>  * None.
>
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 78efebb..f46adb2 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -67,6 +67,7 @@ gumstix       Gumstix, Inc.
>  gw     Gateworks Corporation
>  hannstar       HannStar Display Corporation
>  haoyu  Haoyu Microelectronic Co. Ltd.
> +himax  Himax Technologies, Inc.
>  hisilicon      Hisilicon Limited.
>  hit    Hitachi Ltd.
>  honeywell      Honeywell
> --
> 2.1.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
