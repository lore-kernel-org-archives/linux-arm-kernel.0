From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 14:05:35 +0100
Subject: [PATCH 0/6] pinctrl: pxa: add pxa27x pin control support
In-Reply-To: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
References: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <CACRpkdaJO6noUd_a5d122G3EiO6-u9bu_gZMg1Tky=PS9O5yUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2015 at 7:04 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> I've been working on this for some time now, it's time pxa archtecture gets a
> proper pin control support.
>
> This serie provides support for pxa27x architecture, and paves the way to pxa2xx
> one. I've tested this on my pxa27x board, in both device-tree and non
> device-tree builds.

So in 2013 Haojian removed PXA3xx, MMP2, PXA168 and PXA910 in favor
of using pinctrl-single.c shared with OMAP.

See
commit 62194200e5e383af2085faf35b6f009364446069
"pinctrl: remove pxa pinctrl driver"

What makes the PXA27x so different from its siblings that it still
warrants its own driver? Why can this one not use pinctrl-single
as well?

Yours,
Linus Walleij
