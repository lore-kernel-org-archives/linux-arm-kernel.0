From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 00:40:20 +0200
Subject: [PATCH v4 14/28] ARM64: dts: Add Actions Semi S900 and
 Bubblegum-96
In-Reply-To: <20170606005426.26446-15-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-15-afaerber@suse.de>
Message-ID: <ad4b07e9-bafe-80bc-fc68-3541c914dabf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> UART0/1/4/6 interrupts are guesses.
> 
> Cc: 96boards at ucrobotics.com
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4:
>  * Adopted lower-case timer interrupt-names (Mark)
>  
>  v2 -> v3:
>  * Added remaining UART nodes -- some interrupts are guesses
>  * Added timer node -- only TIMER1 interrupt known
>  
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
>  
>  arch/arm64/boot/dts/Makefile                      |   1 +
>  arch/arm64/boot/dts/actions/Makefile              |   5 +
>  arch/arm64/boot/dts/actions/s900-bubblegum-96.dts |  35 +++++
>  arch/arm64/boot/dts/actions/s900.dtsi             | 164 ++++++++++++++++++++++
>  4 files changed, 205 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/actions/Makefile
>  create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
>  create mode 100644 arch/arm64/boot/dts/actions/s900.dtsi

Applying (with extended commit message) to linux-actions.git v4.13/dt64:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/dt64

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
