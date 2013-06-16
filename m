From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 12:01:13 +0200
Subject: [PATCH] drivers: pinctrl: add active state to core
In-Reply-To: <1370938616-5952-1-git-send-email-linus.walleij@stericsson.com>
References: <1370938616-5952-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdbM2iPoHjJe8zJjqtXKKZpL3S7C1S6OsLDWawFDjtvwuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 10:16 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> In addition to the recently introduced pinctrl core
> control, the PM runtime pin control for the OMAP platforms
> require a fourth state in addtition to the default, idle and
> sleep states already handled by the core: an explicit "active"
> state. Let's introduce this to the core in addition to the
> other states already defined.
>
> Cc: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Suggested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

It seems this thing needs another round of discussion so I've pulled
this patch out of the branch with stuff for -next and rebased dependencies.

Yours,
Linus Walleij
