From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Jan 2013 13:19:19 +0100
Subject: [PATCH] ARM: mach-ux500: enable 128KB way L2 cache on DB8540
In-Reply-To: <1358936878-29806-1-git-send-email-fabio.baltieri@linaro.org>
References: <1358936878-29806-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdZrmq8=_=BwvB9wZYxHEQZRZ1pVqD3+7B=YORU=rpnOOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 11:27 AM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> From: Maxime Coquelin <maxime.coquelin@stericsson.com>
>
> DB8540 L2 was configured with 64KB way size, but it has 128KB as AP9540.
>
> Fix this by modifying ux500_l2x0_init() to use 128KB way size for all
> cpus in the x540 family.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Applied to my ux500-core branch.

Yours,
Linus Walleij
