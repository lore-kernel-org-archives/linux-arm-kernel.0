From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 Apr 2011 23:11:36 +0200
Subject: [FAILED] BLD i.MX51 Referenz + linux-next git kernel
In-Reply-To: <E1Q8IiX-0006uC-GW@himalia.hi.pengutronix.de>
References: <E1Q8IiX-0006uC-GW@himalia.hi.pengutronix.de>
Message-ID: <20110408211136.GC18601@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I haven't looked yet (and won't anymore today), but our autobuilder
failed to build because of something that looks like a arm global
problem.

On Fri, Apr 08, 2011 at 10:55:45PM +0200, Pengutronix Sisyphus Druid wrote:
>                               Source URL .... git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
>                     Kernel configuration .... use config: mx51_defconfig
> [...]
>   CC      arch/arm/kernel/process.o
> arch/arm/kernel/process.c: In function 'cpu_idle':
> arch/arm/kernel/process.c:200: error: implicit declaration of function 'cpuidle_call_idle'
> make[1]: *** [arch/arm/kernel/process.o] Error 1
> make: *** [arch/arm/kernel] Error 2
> make: *** Waiting for unfinished jobs....

Will look into that on Monday if nobody else cares before.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
