From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jul 2014 21:55:20 +0200
Subject: [PATCH 02/12] mfd: ab8500-debugfs: Simplify invalid debugfs data
 checking
In-Reply-To: <1404314924-23564-3-git-send-email-lee.jones@linaro.org>
References: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
 <1404314924-23564-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaEoC0HnNzHeJj2Hw1SKjYxbqEt=AhAFoH5jgWXDQy7jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 2, 2014 at 5:28 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Noticed during a coding review, if we reorganised the checking a
> little, we can rid the code of a pointless 'else'.  Whilst looking
> for this particular code hunk I noticed another pointless 'else',
> which I've subsequently fixed in this patch.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
