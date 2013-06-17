From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 08:24:49 +0200
Subject: [PATCH RESEND v2 1/3] GPIO: clps711x: Rewrite driver for using
 generic GPIO code
In-Reply-To: <1370411967-29451-17-git-send-email-shc_work@mail.ru>
References: <1370411967-29451-1-git-send-email-shc_work@mail.ru>
 <1370411967-29451-17-git-send-email-shc_work@mail.ru>
Message-ID: <CACRpkdYZcRWOp=gzcifn+jgxm=eZcGrTCiSs5_T7RMHWZuJ5gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 5, 2013 at 7:59 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> This patch provides rewritten driver for CLPS711X GPIO which uses
> generic GPIO code.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Alexander are you sending this through ARM SoC?

Alternatively I can carry this in the GPIO tree if there are
no conflicts elsewhere in this next merge window.

Yours,
Linus Walleij
