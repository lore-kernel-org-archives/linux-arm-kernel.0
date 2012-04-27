From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Fri, 27 Apr 2012 12:38:30 +0530
Subject: [PATCH 17/17] ARM: ux500: use machine specific hook for late init
In-Reply-To: <1335454725-13089-18-git-send-email-shawn.guo@linaro.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-18-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120427070829.GA20860@bnru02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 17:38:45 +0200, Shawn Guo wrote:
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500.c       |    4 ++++
>  arch/arm/mach-ux500/board-u5500.c        |    1 +

This might collide with Linus W's patch set which removes the
u5500 support.

Otherwise, looks ok to me.

Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

Thanks,
Srinidhi
