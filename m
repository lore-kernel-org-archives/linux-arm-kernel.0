From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 23:34:26 +0200
Subject: [PATCH 03/16] ARM: ux500: Enable LED heartbeat functionality on
 Snowbal via DT
In-Reply-To: <1337330355-17747-4-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda=6VsvMBArc=QQnpH_dHzJJF+hUZagn7185c2+LYrhRQ@mail.gmail.com>
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

Thanks,
Linus Walleij
