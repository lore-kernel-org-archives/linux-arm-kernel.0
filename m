From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Jan 2016 11:36:31 +0100
Subject: [PATCH] pinctrl: nomadik: hide unused functions
In-Reply-To: <1453737557-1960171-1-git-send-email-arnd@arndb.de>
References: <1453737557-1960171-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYHpeb18SfUU=d_jXtLPFpUe2AkW5JJzMK5giFBw1aKAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 4:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The nomadik pinctrl driver has two functions that are only used
> for debugfs output and are otherwise unused:
>
> drivers/pinctrl/nomadik/pinctrl-abx500.c:194:12: error: 'abx500_get_pull_updown' defined but not used
> drivers/pinctrl/nomadik/pinctrl-abx500.c:471:12: error: 'abx500_get_mode' defined but not used
>
> This makes the function definitions conditional to avoid the
> harmless warnings.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied for fixes.

Yours,
Linus Walleij
