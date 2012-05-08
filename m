From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 May 2012 14:21:34 +0200
Subject: [PATCH 0/4] Add device tree support for gpio-mxs
In-Reply-To: <1336146329-3821-1-git-send-email-shawn.guo@linaro.org>
References: <1336146329-3821-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkda_auTko+ik-efW4_f_fEAa2NOSCqZxN5GV=8LrC6P_OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 5:45 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> This patch series cleans up gpio-mxs a bit, and then adds device tree
> support for the driver. ?Currently, the irqdomain for gpio is still
> added in platform code, and should be moved into driver later with the
> help from the generic-irq-chip irqdomain support.
>
> It's based on mxs device tree branch, and might be easier to go
> via arm-soc tree.

This all looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
