From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Mar 2012 19:37:12 +0200
Subject: [PATCH] ARM: ux500: fix compile error in new timer code
In-Reply-To: <1332931787-27741-1-git-send-email-lee.jones@linaro.org>
References: <1332931787-27741-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbi3JM_iGmWiV9pF0Pff+p9_4taw1aQOpgzprgrnLFdWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 12:49 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch fixes the errors below:
>
> error: implicit declaration of function ?pr_err?
> error: implicit declaration of function ?BUG?
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I'll apply and funnel to ARM-SoC when I'm back in Europe unless
you want to push it to Arnd/Olof directly.

Thanks,
Linus Walleij
