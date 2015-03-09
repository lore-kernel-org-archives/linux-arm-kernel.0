From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 17:10:39 +0100
Subject: [RFC PATCH 10/18] gpio: move msm-v1 driver to mach-msm
In-Reply-To: <1425497592-1831064-11-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
 <1425497592-1831064-11-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdb-WsBxUSFUcRQCGLRrckycbtA_=Z4yKqwnrrj6n3bhMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 4, 2015 at 8:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The msm gpio driver uses the gpiomux infrastructure that
> relies on platform specific internals. We should really
> use a proper pinmux driver here, but for now, the easiest
> solution is to move it into mach-msm to get rid of the
> header file dependency.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
