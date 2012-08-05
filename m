From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Aug 2012 11:45:56 +0200
Subject: [PATCH 1/4] gpio/mxc: remove redundant shadow variables
 initialization
In-Reply-To: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
References: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdZhTFYLEmof9bRoYX0Erjpz+0k7y0wUhsmXtWroX=B3ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 5, 2012 at 8:01 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> With commit 3e11f7b (gpio/generic: initialize basic_mmio_gpio shadow
> variables properly) in place, the shadow variables initialization is
> being done in generic driver bgpio_init call.
>
> Remove the redundant shadow variables initialization from gpio-mxc
> driver.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied.

Thanks,
Linus Walleij
