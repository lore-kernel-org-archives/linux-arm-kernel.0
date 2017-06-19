From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 04:09:00 +0200
Subject: [PATCH v4 19/28] dt-bindings: arm: cpus: Add S500 enable-method
In-Reply-To: <20170606005426.26446-20-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-20-afaerber@suse.de>
Message-ID: <077238b6-0614-ab7a-986b-0582ed3d3ae1@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> The Actions Semi S500 SoC requires a special secondary CPU boot procedure.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4: Unchanged
>  
>  v3: new
>  
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to linux-actions.git v4.13/dt branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
