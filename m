From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 Mar 2015 14:40:52 +0100
Subject: [PATCH v2.0 0/2] ARM: at91: Add pm support for sama5d3 and sama5d4
In-Reply-To: <1425873187-8096-1-git-send-email-wenyou.yang@atmel.com>
References: <1425873187-8096-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <5502E8E4.3010608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/03/2015 04:53, Wenyou Yang a ?crit :
> Hi,
> 
> The patch series purpose is to add pm support for sama5d3 and sama5d4.
> 
> It is based on the branch, at91-4.0-fixes
> git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
> 	+ [PATCH] ARM: AT91: pm improvement for 4.1
> 
> Change log for v2.0:
>  - remove the patch already stacked. 
>  - rebase.
> 
> Wenyou Yang (2):
>   pm: at91: pm_suspend: add the WFI instruction support for ARMv7
>   pm: at91: flush data cache and clean, invalidate and disable the L2
>     cache

For the 2 patches:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked on top of at91-4.1-cleanup: thanks Wenyou!

(also reworked the subjects).

Bye,

> 
>  arch/arm/mach-at91/pm.c         |    6 ++++++
>  arch/arm/mach-at91/pm_suspend.S |   20 +++++++++++++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 


-- 
Nicolas Ferre
