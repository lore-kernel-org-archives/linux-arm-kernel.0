From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 18:30:09 +0200
Subject: [PATCH] pinctrl: export pinctrl_pm_select_*_state
In-Reply-To: <3037061.7rG6iWz9IX@wuerfel>
References: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
 <3037061.7rG6iWz9IX@wuerfel>
Message-ID: <CACRpkdbeFmEx6yZFvUa6B+v9Pd+CieTQR6nvJOUHa9MzQrSufg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 5:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The three functions pinctrl_pm_select_default_state,
> pinctrl_pm_select_sleep_state, and pinctrl_pm_select_idle_state
> are used in drivers that can be loadable modules, and should
> be exported.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

That's right, sorry for missing this :-(

Patch applied!

Yours,
Linus Walleij
