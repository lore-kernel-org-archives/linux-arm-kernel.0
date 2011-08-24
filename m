From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 24 Aug 2011 15:26:56 +0530
Subject: [PATCH 2/3] mach-ux500: initialize l2x0 at arch_init time
In-Reply-To: <1314177826-19151-1-git-send-email-linus.walleij@stericsson.com>
References: <1314177826-19151-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4E54CAE8.1060702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 August 2011 02:53 PM, Linus Walleij wrote:
> From: Linus Walleij<linus.walleij@linaro.org>
>
> mach-imx initialize their l2x0 cach at arch_init time, so
> why shouldn't we.
>
More and more you delay L2 cache enable in boot-process,
your boot-up time is going to shoot-up.

Have you thought about it. Cache's should be enabled as
early as possible.

Regards
Ssantosh
