From: santosh.shilimkar@ti.com (Santosh)
Date: Mon, 05 Sep 2011 13:45:09 +0530
Subject: [PATCH v2] ARM: l2x0: make sure I&D are not locked down on init
In-Reply-To: <1315207128-11197-1-git-send-email-linus.walleij@stericsson.com>
References: <1315207128-11197-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4E64850D.8030107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 September 2011 12:48 PM, Linus Walleij wrote:
> From: Linus Walleij<linus.walleij@linaro.org>
>
> Fighting unfixed U-Boots and other beasts that may the cache in
> a locked-down state when starting the kernel, we make sure to
> disable all cache lock-down when initializing the l2x0 so we
> are in a known state.
>
> Cc: Srinidhi Kasagar<srinidhi.kasagar@stericsson.com>
> Cc: Rabin Vincent<rabin.vincent@stericsson.com>
> Cc: Adrian Bunk<adrian.bunk@movial.com>
> Cc: Rob Herring<robherring2@gmail.com>
> Cc: Catalin Marinas<catalin.marinas@arm.com>
> Cc: Will Deacon<will.deacon@arm.com>
> Reported-by: Jan Rinze<janrinze@gmail.com>
> Tested-by: Robert Marklund<robert.marklund@stericsson.com>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
> ---
Looks good to me.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
