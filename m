From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 1 Sep 2011 20:02:51 +0530
Subject: [PATCH] [ARM] davinci: gpio: eliminate unused variable warnings
In-Reply-To: <1313386893.25484.1.camel@phoenix>
References: <1313386893.25484.1.camel@phoenix>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930257268CEC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On Mon, Aug 15, 2011 at 11:11:33, Axel Lin wrote:
> Since commit 5093aec872e5be7a55d8dd2b639e8a3818dc19db
> "arm: davinci: Cleanup irq chip code", 
> the variable 'mask' and 'g' are not being used in gpio_irq_type.
> 
> This patch eliminate below unused variable warnings:
> 
>   CC      arch/arm/mach-davinci/gpio.o
> arch/arm/mach-davinci/gpio.c: In function 'gpio_irq_type':
> arch/arm/mach-davinci/gpio.c:234: warning: unused variable 'mask'
> arch/arm/mach-davinci/gpio.c:233: warning: unused variable 'g'
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Thanks for the fix! There is a patch in linux-next
committed by Russell which moves the DaVinci gpio driver
to drivers/gpio/. 

Can you please redo this fix to apply on linux-next?

Once Russell approves, it can go though his patch
system so there are no conflicts.

Thanks,
Sekhar
