From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Aug 2012 15:24:23 +0200
Subject: [PATCH 5/6] ARM: integrator: include <linux/export.h
In-Reply-To: <1344430493-5304-6-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
 <1344430493-5304-6-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYbHTtOg6inbemD2SG+XT9ZYN3pcFQjEPv7mbyecagawg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 2:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Without this patch, building integrator_defconfig results in:
>
> arch/arm/mach-integrator/core.c:150:1: warning: data definition has no type or storage class [enabled by default]
> arch/arm/mach-integrator/core.c:150:1: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
> arch/arm/mach-integrator/core.c:150:1: warning: parameter names (without types) in function declaration [enabled by default]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>

Missing a ">" at the end of the subject line, but whatever.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
