From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 20 Sep 2017 16:56:01 +0200
Subject: [PATCH v2 0/2] ARM: Actions Semi S500 SMP cleanups
In-Reply-To: <20170905212000.7009-1-afaerber@suse.de>
References: <20170905212000.7009-1-afaerber@suse.de>
Message-ID: <2a13d28a-7115-ee18-a131-081c58115c70@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 05.09.2017 um 23:19 schrieb Andreas F?rber:
> Hello,
> 
> This mini-series further cleans up the SMP code for Actions Semi S500 SoC.
> 
> @David, can you please reply with an Acked-by for the second patch? Thanks!
> 
> Work branch for testing:
> https://github.com/afaerber/linux/commits/bg96-next
> 
> Have a lot of fun!
> 
> Cheers,
> Andreas
> 
> v1 -> v2:
> * Prepended __pa_symbol cleanup (Florian)
> 
> Cc: David Liu <liuwei@actions-semi.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> 
> Andreas F?rber (2):
>   ARM: owl: smp: Use __pa_symbol()
>   ARM: owl: smp: Drop owl_secondary_boot()

No further review from David or Florian on v1 or this v2, so applied to
v4.15/arm now:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.15/arm

Regards,
Andreas

>  arch/arm/mach-actions/Makefile  |  4 +---
>  arch/arm/mach-actions/headsmp.S | 52 -----------------------------------------
>  arch/arm/mach-actions/platsmp.c |  2 +-
>  3 files changed, 2 insertions(+), 56 deletions(-)
>  delete mode 100644 arch/arm/mach-actions/headsmp.S

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
