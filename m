From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Feb 2015 13:55:19 +0100
Subject: [PATCH 08/10] ARM: no longer make CPU targets visible separately
In-Reply-To: <1424967096-261582-2-git-send-email-arnd@arndb.de>
References: <1424967096-261582-1-git-send-email-arnd@arndb.de>
 <1424967096-261582-2-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdbvECKX9FObB0mPv0yAVAQ4nmEwhaYN_sZKBi8YtRGcAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 5:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Now that realview and integrator always select the correct CPU
> type themselves based on the core tiles, there is no need to
> still have them user-visible in arch/arm/mm/Kconfig. The
> ARM925T symbol has been selected by the only user for many
> years, so that can be removed along with the realview and
> integrator specific ones.
>
> This also solves randconfig build problems on realview.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
