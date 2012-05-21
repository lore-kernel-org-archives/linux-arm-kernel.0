From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 23:33:52 +0200
Subject: [PATCH 02/16] ARM: ux500: Enable LED heartbeat functionality on
 Snowball
In-Reply-To: <1337330355-17747-3-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYiwjXiiR_WC9BvWt=dtXfMHXwSVhcfk4W+yQ6_D+paHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 10:39 AM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch configures the user LED on Snowball to double flash
> every second or so, whilst it's still alive. This can give key
> indications as to what the board is doing in the case of no
> console output.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This doesn't look like it has anything to do with the DT stuff, shall
I queue it in the ux500 tree?

Yours,
Linus Walleij
