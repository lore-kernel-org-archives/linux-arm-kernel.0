From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Apr 2013 10:26:12 +0200
Subject: [PATCH] ARM: ux500: update V-INTCORE constraints
In-Reply-To: <1364397694-14126-1-git-send-email-fabio.baltieri@linaro.org>
References: <1364397694-14126-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdYgCxf9R1aU2QdPUBxErhK=E2tM=6L-yMLA_L3+ntj3nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 4:21 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Update V-INTCORE regulator constraints to allow voltage and
> configuration changes from consumer drivers.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
> Hi Linus,
>
> this patch adds the regulators bits I'm missing for ux500-musb patches.
> Without this I just get a runtime warning like:
>
> V-INTCORE: operation not allowed
>
> but the driver works anyway and there are no build dependencies, so I
> think this can safely go in the arm-soc tree on its own, and the whole
> thing should work happily in -next.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I know that Lee's been sending off a large set of regulator patches
lately, some include alterations to this platform config.

Maybe it's better to take this patch into the regulator tree if these
machine configs will come in that way? Also like Lee to have a
look at this...

Yours,
Linus Walleij
