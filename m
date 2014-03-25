From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Mar 2014 15:09:28 +0100
Subject: [PATCH 43/62] ARM: integrator: only select pl01x if TTY is enabled
In-Reply-To: <1395257399-359545-44-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-44-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYSPnTWE8pz3UfbmPAHvCnr2Fd4rvCnoovj2UY1cnpMOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 8:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Building the integrator platform without TTY support currently
> results in a build failure because we always turn on the
> pl010 or pl011 drivers. Changing this to a conditional 'select'
> statement enables us to build more random configurations, although
> it should have little impact for practical configurations.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
