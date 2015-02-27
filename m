From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Feb 2015 13:57:14 +0100
Subject: [PATCH 10/10] ARM: realview: clean up header files
In-Reply-To: <1424967115-261730-1-git-send-email-arnd@arndb.de>
References: <1424967115-261730-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdbk01F5Ybo4eA46qo3b9JAD4boxhwHMO-juogKOFHtTgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 5:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> This contains multiple trivial cleanups to the realview headers:
>
> - removing the file names from the introductory comment
> - removing the uncompress.h header that is unused
> - removing the irqs.h header and NR_IRQS logic that is
>   obsoleted by sparse IRQs
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
