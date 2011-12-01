From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Dec 2011 17:11:45 +0100
Subject: [PATCH] [WATCHDOG] move coh901327 state holders
In-Reply-To: <1317631978-22818-1-git-send-email-linus.walleij@stericsson.com>
References: <1317631978-22818-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdb9+ZsnXFbjJXg-=amnVwYu_EyKftYxRptjq8SDoqurvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 3, 2011 at 10:52 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> The state holders used in the PM path of the drivers report as
> unused variables when compiling without CONFIG_PM so let's
> move them inside CONFIG_PM.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Ping on this, Wim is this patch OK?

Yours,
Linus Walleij
