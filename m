From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 01:17:20 +0200
Subject: [PATCH 6/9] ARM: OMAP: Move gpio.h to include/linux/platform_data
In-Reply-To: <20120831005234.28732.10624.stgit@muffinssi.local>
References: <20120831004828.28732.902.stgit@muffinssi.local>
 <20120831005234.28732.10624.stgit@muffinssi.local>
Message-ID: <CACRpkdb7ozr8uxTDudVPMF5Lcr3FMtDLo9RUm-hvqbVUCHji6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 2:52 AM, Tony Lindgren <tony@atomide.com> wrote:

> This way we can remove includes of plat/gpio.h which won't work
> with the single zImage support.
>
> Note that we also remove the cpu_class_is_omap2() check
> in gpio-omap.c as the drivers should not call it as we need to
> make it local to arch/arm/mach-omap2 for single zImage support.
>
> While at it, arrange the related includes in the standard way.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-mtd at lists.infradead.org
> Cc: alsa-devel at alsa-project.org
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
