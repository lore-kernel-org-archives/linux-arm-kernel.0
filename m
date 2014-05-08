From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 May 2014 23:09:14 +0200
Subject: [PATCH] clk/versatile: export symbols for impd1
In-Reply-To: <1399560990-1402858-5-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-5-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZK4XDxkQNjuDbaeptw3i6CEM_gaH8iWXu3inNN9WD3yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 8, 2014 at 4:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The impd1 code on mach-integrator can be a loadable module,
> so we have to export icst_clk_register, integrator_impd1_clk_init
> and integrator_impd1_clk_exit.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
