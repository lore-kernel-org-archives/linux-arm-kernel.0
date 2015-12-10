From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Dec 2015 00:18:34 +0100
Subject: [PATCH 05/10] ARM: debug-ll: rework integrator/versatile handling
In-Reply-To: <1449268242-808553-6-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
 <1449268242-808553-6-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdb8uUmcQgQ2nDRNkZgMs9h-OFyVnReaJ+mZDtyWMtExgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 4, 2015 at 11:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Enabling one of the integrator platforms in a multiplatform kernel
> while trying to use DEBUG_LL for another platform can default to
> the wrong UART address, as the options are purely based on the
> architecture being enabled or not.
>
> This changes the logic to use the integrator default addresses only
> if we have also picked the respective Kconfig symbols introduced
> here. Versatile is not yet part of multiplatform, but hopefully
> soon will be, so we do the same change for versatile as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
