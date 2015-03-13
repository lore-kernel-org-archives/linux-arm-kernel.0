From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 Mar 2015 11:04:03 +0100
Subject: [PATCH v2.0 0/3] ARM: AT91: pm cleanup for 4.1
In-Reply-To: <1425872581-7570-1-git-send-email-wenyou.yang@atmel.com>
References: <1425872581-7570-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <5502B613.6090900@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/03/2015 04:43, Wenyou Yang a ?crit :
> Hi,
> 
> The patch series purpose is to clean up the AT91 PM code.
> 
> It is based on the branch: at91-4.0-fixes
> git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
> 	+ [PATCH] ARM: at91: pm: change at91_pm_set_standby() to static
> 
> Change log for v2.0
>  - rebase on the branch: at91-4.0-fixes + the above patch. 
> 
> Wenyou Yang (3):
>   pm: at91: pm_slowclock: remove the unused code related with
>     SLOWDOWN_MASTER_CLOCK
>   ARM: at91: move "select SRAM" under SOC_AT91SAM9 and SOC_SAMA5
>   pm: at91: remove CONFIG_AT91_SLOW_CLOCK config option

Whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked on top of at91-4.1-cleanup: thanks for your patience Wenyou ;-)

> 
>  arch/arm/mach-at91/Kconfig        |   17 +++--------------
>  arch/arm/mach-at91/Makefile       |    2 +-
>  arch/arm/mach-at91/pm.c           |   12 +-----------
>  arch/arm/mach-at91/pm_slowclock.S |   37 -------------------------------------
>  4 files changed, 5 insertions(+), 63 deletions(-)
> 


-- 
Nicolas Ferre
