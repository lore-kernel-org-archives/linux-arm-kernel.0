From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 09:29:47 +0200
Subject: [PATCH 1/2] ARM: integrator_cp: Set LCD{0,1} enable lines when
 turning on CLCD
In-Reply-To: <1374594138-17080-2-git-send-email-jonathan.austin@arm.com>
References: <1374594138-17080-1-git-send-email-jonathan.austin@arm.com>
 <1374594138-17080-2-git-send-email-jonathan.austin@arm.com>
Message-ID: <CACRpkdbHVk7PgvSVsTdFLgAw5+GCH7yqT06OpLJ5jn2Y-AgqOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 5:42 PM, Jonathan Austin
<jonathan.austin@arm.com> wrote:

> This turns on the internal integrator LCD display(s). It seems that the code
> to do this got lost in refactoring of the CLCD driver.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>

I wonder if these bits should really be set if you have only VGA?
I don't think it hurts but I'm a bit picky with the details...

Anyway since it's a regression:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

You can send it to arm at kernel.org as a fix and ask that the
ARM SoC maintainers apply it directly, also add
Cc: stable at vger.kernel.org so the fix is applied backward.

Yours,
Linus Walleij
