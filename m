From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Dec 2015 11:06:02 +0100
Subject: [PATCH] ARM: default to multi_v7_defconfig
In-Reply-To: <2084866.x9T7k7V9eW@wuerfel>
References: <2084866.x9T7k7V9eW@wuerfel>
Message-ID: <CACRpkdZ+9rq+tVbJ_H+wu1Cmv7aWJRZPcukrqKKgJq+H6k6gaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 11:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> versatile_defconfig has not been a reasonable default for a very long
> time, there is very little work happening on this platform and it's
> based on an old ARM926 CPU core.
>
> This changes the default to multi_v7_defconfig, which is much more
> relevant to anyone doing a build test on ARM, as it covers a wide
> range of platforms.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
