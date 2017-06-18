From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 00:29:23 +0200
Subject: [PATCH v4 13/28] dt-bindings: arm: Document Actions Semi S900
In-Reply-To: <20170606005426.26446-14-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-14-afaerber@suse.de>
Message-ID: <423ef831-329c-0b26-015d-0ad242bc7ec0@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> The Actions Semi S900 is a quad-core ARM Cortex-A53 SoC.
> The Bubblegum-96 is a 96Boards Consumer Edition compliant board (4/96).
> 
> Cc: 96boards at ucrobotics.com
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3 -> v4: unchanged
>  
>  v1 -> v2:
>  * Adopted "actions" vendor prefix
>  * Extended text
>  
>  Documentation/devicetree/bindings/arm/actions.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Still no comments from uCRobotics received...

Due to S500 dependency applying to linux-actions.git v4.13/dt branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/dt

Let me know if we need a topic branch for dt+dt64 instead.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
