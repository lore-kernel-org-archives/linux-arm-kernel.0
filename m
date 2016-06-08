From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 13:37:12 +0200
Subject: [PATCH 4/4] mfd: db8500 stop passing around platform data
In-Reply-To: <1462889050-2818609-1-git-send-email-arnd@arndb.de>
References: <1462889050-2818609-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZdR1rESjgD-p=79Jk3sp+Xi4ER1vYOsKcr6aAfHztpiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 4:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Except for the constant DB8500_PRCMU_FW_VERSION_OFFSET number, nothing
> is ever passed through the platform data and used in a driver, so we
> can simply stop passing it around.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Do you think it's relevant for Lee to take this or do you want to
have it in ARM SoC together with the other cleanups (that I
haven't had time to look at...)?

In the latter case I need an ACK from Lee to apply it for a pull
request to ARM SoC.

The functionality it pertains to is out-of-tree but if we want to
reintroduce it, it should happen through DT anyway.

Yours,
Linus Walleij
