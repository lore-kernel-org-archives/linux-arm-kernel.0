From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Jan 2013 21:51:32 +0000
Subject: [PATCH v4 15/19] ARM: samsung: remove unused tick.h
In-Reply-To: <1357235668-9450-16-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-16-git-send-email-robherring2@gmail.com>
Message-ID: <201301032151.32337.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 January 2013, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Remove tick.h on s5p64x0 and s5pv210 as they are unused.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> ---
>  arch/arm/mach-s5pv210/include/mach/tick.h |   26 --------------------------
>  arch/arm/plat-samsung/s5p-irq-eint.c      |    1 +
>  2 files changed, 1 insertion(+), 26 deletions(-)
>  delete mode 100644 arch/arm/mach-s5pv210/include/mach/tick.h

The second half of the patch does not relate to the description,
and the first half looks correct but out of place here.

Did you accidentally fold another patch into the one you wanted,
or am I just misreading the intention of the patch?

	Arnd
