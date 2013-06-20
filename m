From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Jun 2013 10:01:20 +0200
Subject: [GIT PULL] U300 multiplatform for v3.11
In-Reply-To: <201306200227.31603.arnd@arndb.de>
References: <CACRpkdY1EUbFK6Mk3nogjGGeSkmio2v6ZNFe1wh7sFcE3d51fg@mail.gmail.com>
 <201306200227.31603.arnd@arndb.de>
Message-ID: <CACRpkdb8WZi3FQuhKcZt4N7OZHAVpQsy45Dpcn+hYay42exqoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 2:27 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> I needed this patch on top.
>
> From e0a60445624107912e4684e20e5e9158b94b4c87 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 20 Jun 2013 02:26:37 +0200
> Subject: [PATCH] ARM: u300: only build for ARCH_MULTI_V5
>
> This avoids impossible platform combinations, as we cannot
> build a combined V5 + V6/V7 kernel.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Of course...
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
