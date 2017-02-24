From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 24 Feb 2017 04:49:50 +0100
Subject: [RFC v2 13/17] ARM64: dts: Add Actions Semi S900 and Bubblegum-96
In-Reply-To: <20170224034055.18807-14-afaerber@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-14-afaerber@suse.de>
Message-ID: <bf4b321b-3bac-3c52-7136-4ba293e97c2e@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.02.2017 um 04:40 schrieb Andreas F?rber:
> Cc: 96boards at ucrobotics.com
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Reworded subject
>  * Added memory at 0 node for Bubblegum-96 (Mark)
>  * Filled in reserved-memory sub-node for Bubblegum-96 (Mark)
>  * Added arm-pmu interrupt-affinity property (Mark)
>  * Changed second GIC reg size 0x1000 -> 0x2000 for Bubblegum-96 (Mark)
>  * Updated ARCH_OWL to ARCH_ACTIONS (Arnd)
>  * Renamed s900-bubblegum96.dts to s900-bubblegum-96.dts
>  * Adopted "actions" vendor prefix
>  * Dropped irq.h include
>  * Adopted SPDX-License-Identifier (Rob)

Sorry, not this patch but the tty patches 15ff/17 should've been RFC.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
