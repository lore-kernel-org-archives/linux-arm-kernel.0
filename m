From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 04 Oct 2010 07:50:35 -0700
Subject: [PATCH 5/5] arm/davinci: remove duplicated include
In-Reply-To: <20101004123947.1e89128f@absol.kitzblitz> (Nicolas Kaiser's
	message of "Mon, 4 Oct 2010 12:39:47 +0200")
References: <20101004122436.7092868f@absol.kitzblitz>
	<20101004123947.1e89128f@absol.kitzblitz>
Message-ID: <87fwwm3tc4.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Kaiser <nikai@nikai.net> writes:

> Remove duplicated include.
>
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>

Applied, thanks.  Queuing for 2.6.37.

Kevin

> ---
>  arch/arm/mach-davinci/board-da850-evm.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index fdc2cc5..851cc45 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -26,7 +26,6 @@
>  #include <linux/mtd/physmap.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/regulator/tps6507x.h>
> -#include <linux/mfd/tps6507x.h>
>  #include <linux/input/tps6507x-ts.h>
>  
>  #include <asm/mach-types.h>
