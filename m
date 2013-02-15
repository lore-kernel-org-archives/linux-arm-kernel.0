From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 10:12:39 +0100
Subject: [PATCH 06/11] ARM: integrator/versatile: fix NOMMU warnings
In-Reply-To: <1360849767-1463135-7-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <1360849767-1463135-7-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdacWrY=Bb-1e+eicFYD3bQCkPjFbcX==sy_aSNa25g8BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 2:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On NOMMU kernels, the io_desc variables are unused
> because we don't use the MMU to remap the MMIO
> areas.
>
> Marking these variables as __maybe_unused easily
> avoids the otherwise harmless warnings like
>
> warning: 'versatile_io_desc' defined but not used
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
