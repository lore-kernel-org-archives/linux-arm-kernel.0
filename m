From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Nov 2012 12:30:11 +0000
Subject: [PATCH 1/2] ARM: ux500: add PRCM register base for pinctrl
In-Reply-To: <1352375731-29570-1-git-send-email-linus.walleij@stericsson.com>
References: <1352375731-29570-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201211081230.11595.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 November 2012, Linus Walleij wrote:
> From: Jonas Aaberg <jonas.aberg@stericsson.com>
> 
> This adds the PRCM register range base as a resource to
> the pinctrl driver do we can break the dependency to the
> PRCMU driver and handle these registers in the driver
> alone.
> 
> Cc: arm at kernel.org
> Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
