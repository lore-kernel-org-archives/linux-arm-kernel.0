From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 18 Jun 2017 20:48:03 +0200
Subject: [PATCH v4 02/28] dt-bindings: arm: Document Actions Semi S500
In-Reply-To: <20170606005426.26446-3-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-3-afaerber@suse.de>
Message-ID: <45ba483d-e359-7a70-3278-bd737a00ad11@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC.
> The LeMaker Guitar is an SODIMM-format module with that SoC.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3 -> v4: unchanged
>  
>  v1 -> v2:
>  * Adopted "actions" vendor prefix
>  * Extended text
>  
>  Documentation/devicetree/bindings/arm/actions.txt | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/actions.txt

Thanks, applied:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
