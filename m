From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 27 Feb 2017 15:57:19 +0100
Subject: [PATCH v2 01/17] dt-bindings: Add vendor prefix for Actions Semi
In-Reply-To: <20170224034055.18807-2-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-2-afaerber@suse.de>
Message-ID: <06838745-f8f2-756f-9719-2e7da8964203@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.02.2017 um 04:40 schrieb Andreas F?rber:
> Actions Semiconductor was listed on NASDAQ as ACTS until Dec 16, 2016.
> 
> Cc: mp-cs at actions-semi.com
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Reverted from "acts" to "actions" (cf. IAP140 "mrvl" vs. "marvell")
>  
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index a76b981..64f8469 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -6,6 +6,7 @@ using them to avoid name-space collisions.
>  abcn	Abracon Corporation
>  abilis	Abilis Systems
>  active-semi	Active-Semi International Inc
> +actions	Actions Semiconductor Co., Ltd.

If the use of "actions" gets ack'ed, I realize it should move one line up.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
