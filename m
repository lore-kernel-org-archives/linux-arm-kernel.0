From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Dec 2012 17:51:02 +0100
Subject: [PATCH 1/1] ARM: ux500: Change IRQ from low-to-high edge
 triggered to high-to-low
In-Reply-To: <1354289099-17931-1-git-send-email-lee.jones@linaro.org>
References: <1354289099-17931-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdafvpnyq7YMV=iSjN4+u1hpt3xntAb-daJZifG9VpgnOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 4:24 PM, Lee Jones <lee.jones@linaro.org> wrote:

> When the STMPE IRQ is triggered to be active high level-sensitive, the
> Nomadik GPIO controller it uses complains, although it still works.
> Recently we attempted to move triggering to low-to-high in an attempt
> to prevent the warning; however, this ensured that the IRQ was actually
> missed completely. Now we have a solution which both works and keeps the
> GPIO controller happy.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Is this something I should put into the ux500 tree or will you
take care of this in a separate pull request?

Yours,
Linus Walleij
