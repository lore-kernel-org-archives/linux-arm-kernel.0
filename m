From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Feb 2015 13:21:17 +0100
Subject: [PATCH 02/10] ARM: realview: don't map undefined PCI registers
In-Reply-To: <1424966890-260805-3-git-send-email-arnd@arndb.de>
References: <1424966890-260805-1-git-send-email-arnd@arndb.de>
 <1424966890-260805-3-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYe91jRBY-+_zBkZqdC7-bQVJhbaks3ygxs214Oua5YDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 5:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> PCI support for realview was never merged, and trying to build realview with
> CONFIG_PCI enabled fails because the constants for the mapping windows are
> not defined anywhere.
>
> This removes them from the static I/O window mapping table as a preparation
> for multiplatform support.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
