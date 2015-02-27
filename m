From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Feb 2015 13:56:07 +0100
Subject: [PATCH 09/10] ARM: realview: make all header files local
In-Reply-To: <1424967109-261656-1-git-send-email-arnd@arndb.de>
References: <1424967109-261656-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdberO-xwi6r=k3NatoSqTTbzOPoQ8rSYZVvKYwSvZ=Eew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 5:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Nothing includes these files any more, so we can simply move them
> from arch/arm/mach-realview/include/mach/ to arch/arm/mach-realview.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Very, very nice.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
