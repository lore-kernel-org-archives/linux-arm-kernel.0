From: hector.oron@gmail.com (Hector Oron)
Date: Sun, 5 Jun 2011 20:36:10 +0200
Subject: [PATCH] plat-iop: fixes fail to build from source
Message-ID: <BANLkTi=3uYdS+04zX_2vWLcOmEgr8aRQQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Resending and adding subject. Apologies for inconveniences.

2011/6/5 Hector Oron <hector.oron@gmail.com>:
> From ace377ade6dce2e3cca400281f8be60398f0c04c Mon Sep 17 00:00:00 2001
> From: Hector Oron <hector.oron@gmail.com>
> Date: Sun, 5 Jun 2011 19:24:09 +0100
> Subject: [PATCH] plat-iop: fixes fail to build from source
>
> ?arch/arm/plat-iop/cp6.c:42: error: 'MODE_MASK' undeclared here (not in a function)
> ?arch/arm/plat-iop/cp6.c:43: error: 'SVC_MODE' undeclared here (not in a function)
>
> Signed-off-by: Hector Oron <hector.oron@gmail.com>
> ---
> ?arch/arm/plat-iop/cp6.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-iop/cp6.c b/arch/arm/plat-iop/cp6.c
> index 9612a87..bab73e2 100644
> --- a/arch/arm/plat-iop/cp6.c
> +++ b/arch/arm/plat-iop/cp6.c
> @@ -18,6 +18,7 @@
> ?*/
> ?#include <linux/init.h>
> ?#include <asm/traps.h>
> +#include <asm/ptrace.h>
>
> ?static int cp6_trap(struct pt_regs *regs, unsigned int instr)
> ?{
> --
> 1.7.4.1
>
>



-- 
?H?ctor Or?n ?-.. . -... .. .- -. ? -.. . ...- . .-.. --- .--. . .-.

<free spam>
-- Would you like to make a donation for Debian Conference?
? ?** http://debconf11.debconf.org/payments.xhtml **
</free spam>
