From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Mar 2012 20:35:42 +0100
Subject: [PATCH 1/3] led-class: change back LEDS_CLASS to tristate instead
 of bool
In-Reply-To: <1331197863-25564-1-git-send-email-bryan.wu@canonical.com>
References: <1331197863-25564-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <CACRpkdYA3kjhnaeC2whfTEynJDB+MO=GQXd6TZfSSRGWzTUZEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 8, 2012 at 10:11 AM, Bryan Wu <bryan.wu@canonical.com> wrote:

> After moving some core functions to led-core.c, led-class.c can be built as
> module again.
>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>

Thanks for driving this Bryan,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
