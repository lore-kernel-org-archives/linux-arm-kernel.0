From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 30 Sep 2012 23:39:42 +0200
Subject: [PATCH 10/12] gpio: pcf857x: select IRQ_DOMAIN
In-Reply-To: <1348868177-21205-11-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-11-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYjCQd91O=G9bnZNGtqBjKzwXN1JedLfvPU_Uq4LXboPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 11:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Patch 6e20a0a4 "gpio: pcf857x: enable gpio_to_irq() support"
> added IRQ domain support to the pcf857x driver, but some configurations
> (e.g. davinci_all_defconfig) don't already enable CONFIG_IRQ_DOMAIN.

Excellent patch Arnd thanks for this!
Applied to my GPIO tree (where the offending patch is queued).

Yours,
Linus Walleij
