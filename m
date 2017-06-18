From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 18 Jun 2017 20:46:33 +0200
Subject: [PATCH v4 01/28] dt-bindings: Add vendor prefix for Actions Semi
In-Reply-To: <20170606005426.26446-2-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-2-afaerber@suse.de>
Message-ID: <73b532f1-2339-c660-53fe-2bb25a265c22@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:53 schrieb Andreas F?rber:
> Actions Semiconductor was listed on NASDAQ as ACTS until Dec 16, 2016.
> 
> Cc: mp-cs at actions-semi.com
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4: Unchanged
>  
>  v2 -> v3:
>  * Fixed sort order after rename
>  
>  v1 -> v2:
>  * Reverted from "acts" to "actions" (cf. IAP140 "mrvl" vs. "marvell")
>  
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

With still no Acked-by or other reply from Actions, I have now applied
this patch to linux-actions.git v4.13/dt branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
