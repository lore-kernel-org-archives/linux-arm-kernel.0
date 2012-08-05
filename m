From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Aug 2012 22:48:41 +0200
Subject: [PATCH] ARM: integrator: use clk_prepare_enable() for timer
In-Reply-To: <1344199075-4111-1-git-send-email-linus.walleij@linaro.org>
References: <1344199075-4111-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdZqaJhCYuW+3WYacjuwJ3zshAexDqLSUJgCCDzVS+=X7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 5, 2012 at 10:37 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> The Integrator timer is using the clock framework to get the
> timer frequency, but missed to prepare the clock before enabling.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Arnd, Olof,

If this patch looks OK to you I request that you apply it alone, no pull
requests, too much hazzle for a single patch...

Yours,
Linus Walleij
