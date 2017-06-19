From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 04:01:52 +0200
Subject: [PATCH v5 10/27] ARM: dts: Add Actions Semi S500 and LeMaker
 Guitar
In-Reply-To: <20170619010828.3401-1-afaerber@suse.de>
References: <3a132688-07d9-cc3f-b4d1-85a95199ec93@suse.de>
 <20170619010828.3401-1-afaerber@suse.de>
Message-ID: <db4b8f3a-197c-ae39-0c42-765cea228ae1@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.06.2017 um 03:08 schrieb Andreas F?rber:
> Add Device Trees for Actions Semiconductor S500 SoC and LeMaker Guitar SoM
> and base board.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v4 -> v5:
>  * Renamed files from s500* to owl-s500*
> 
>  v3 -> v4:
>  * Adopted lower-case timer interrupt-names (Mark)
>  
>  v2 -> v3:
>  * Fixed uart2 reg offset
>  * Enlarged timer reg size
>  * Added 2 Hz timer interrupts, interrupt-names
>  * Disabled CPUs 1-3 for now (cf. later patches)
>  * Added Cortex-A9 SCU, global timer, TWD timer/wdt nodes
>  * Added HOSC clock for timer
>  
>  v1 -> v2:
>  * Reworded subject
>  * Updated ARCH_OWL to ARCH_ACTIONS (Arnd)
>  * Adopted "actions" vendor prefix
>  * Dropped irq.h include
>  * Added memory at 0 node for Guitar SoM
>  * Dropped bogus uart3 clock-frequency
>  * Added device_type for CPU nodes
>  * Fixed UART reg size
>  * Adopted SPDX-License-Identifier (Rob)
>  * Added remaining UART nodes
>  * Added timer node
>  
>  arch/arm/boot/dts/Makefile                     |   2 +
>  arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |  26 ++++
>  arch/arm/boot/dts/owl-s500-guitar.dtsi         |  22 ++++
>  arch/arm/boot/dts/owl-s500.dtsi                | 176 +++++++++++++++++++++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
>  create mode 100644 arch/arm/boot/dts/owl-s500-guitar.dtsi
>  create mode 100644 arch/arm/boot/dts/owl-s500.dtsi

Applying to linux-actions.git v4.13/dt branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
