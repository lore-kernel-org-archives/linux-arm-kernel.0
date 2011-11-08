From: khilman@ti.com (Kevin Hilman)
Date: Tue, 08 Nov 2011 11:24:11 -0800
Subject: [PATCH] arm: omap2: fix build failure
In-Reply-To: <1320726849-11854-1-git-send-email-tom.leiming@gmail.com> (tom
 leiming's message of "Tue, 8 Nov 2011 12:34:09 +0800")
References: <1320726849-11854-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <87mxc61kpw.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tom.leiming at gmail.com writes:

> From: Ming Lei <tom.leiming@gmail.com>
>
> The patch fixes the compile failure:
>
>   CC      arch/arm/mach-omap2/cpuidle34xx.o
> arch/arm/mach-omap2/cpuidle34xx.c:317:12: error: 'THIS_MODULE'
> undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/cpuidle34xx.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> make: *** Waiting for unfinished jobs....
>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

FYI...

Tony has already queued fix for this in his fixes branch.

     http://marc.info/?l=linux-arm-kernel&m=132071036621713&w=2

Kevin
