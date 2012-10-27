From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 27 Oct 2012 16:48:45 +0200
Subject: [GIT PULL] at91: fixes for 3.7-rc3
In-Reply-To: <201210262053.11498.arnd@arndb.de>
References: <5088F131.5040600@atmel.com>
 <201210262053.11498.arnd@arndb.de>
Message-ID: <20121027144845.GI18964@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:53 Fri 26 Oct     , Arnd Bergmann wrote:
> On Thursday 25 October 2012, Nicolas Ferre wrote:
> >       ARM: at91: fix external interrupts in non-DT case
> 
> This patch now leads to build errors with at91x40_defconfig,
> which I've fixed up by applying the patch below on top.
> 
> Please yell if this is not the right fix.
> 
> 	Arnd
> 
> commit 3a8852afde01682083028ee427e0678f9bbddd75
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Fri Oct 26 22:49:09 2012 +0200
> 
>     ARM: at91: fix at91x40 build
>     
>     patch 738a0fd7 "ARM: at91: fix external interrupts in non-DT case"
>     fixed a run-time error on some at91 platforms but did not apply
>     the same change to at91x40, which now doesn't build.
>     
>     This changes at91x40 in the same way that the other platforms
>     were changed.
>     
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
