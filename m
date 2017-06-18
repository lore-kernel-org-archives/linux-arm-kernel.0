From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 18 Jun 2017 23:21:07 +0200
Subject: [PATCH v4 06/28] ARM: Prepare Actions Semi S500
In-Reply-To: <20170606005426.26446-7-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-7-afaerber@suse.de>
Message-ID: <e36c9060-66fa-1893-fc19-bb0d44e37c4c@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> Add ARCH_ACTIONS and mach-actions/owl.c for "actions,s500".
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4: Unchanged
>  
>  v2 -> v3:
>  * Selected AMBA, global timer, TWD drivers
>  * Fixed copy&paste in machine definition (Alberto)
>  
>  v1 -> v2:
>  * Renamed ARCH_OWL to ARCH_ACTION (Arnd)
>  * Renamed mach-owl to mach-actions, leaving owl.c
>  * Adopted "actions" vendor prefix
>  * Selected new clocksource driver
>  
>  arch/arm/Kconfig               |  2 ++
>  arch/arm/Makefile              |  1 +
>  arch/arm/mach-actions/Kconfig  | 15 +++++++++++++++
>  arch/arm/mach-actions/Makefile |  1 +
>  arch/arm/mach-actions/owl.c    | 28 ++++++++++++++++++++++++++++
>  5 files changed, 47 insertions(+)
>  create mode 100644 arch/arm/mach-actions/Kconfig
>  create mode 100644 arch/arm/mach-actions/Makefile
>  create mode 100644 arch/arm/mach-actions/owl.c

Applied to linux-actions.git v4.13/arm branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/arm

There have been no more comments - I believe we could simplify it with a
Makefile hack as seen in mach-uniphier, but since no one asked for
dropping owl.c in 4 patch revisions, I'll consider that as follow-up.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
