From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jul 2012 22:21:34 +0200
Subject: [PATCH] ARM: ux500: Pass PMU platform data due for Perf though
 AUXDATA
In-Reply-To: <1341577958-8521-1-git-send-email-lee.jones@linaro.org>
References: <1341577958-8521-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdboCpR0wC+KffKPhV3MUG3CSh56WxjqKNPPtTJKp7KY9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2012 at 2:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> When booting with Device Tree we need a way to call-back to the
> DB8500 PMU IRQ handler. This is necessary because the two CPU
> IRQ lines are muxed together on the DB8500 chip. The DB8500
> PMU IRQ handler contains logic to pass over to the other core
> in the case of IRQ_NONE. This patch allows the DB8500 PMU IRQ
> handler to be passed to Perf through platform data.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Makes perfect sense.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
