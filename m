From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Aug 2013 00:25:05 +0200
Subject: [PATCH] pinctrl: samsung: Parse pin groups before calling
 pinctrl_register()
In-Reply-To: <1377015381-26455-1-git-send-email-t.figa@samsung.com>
References: <1377015381-26455-1-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdaNzXtVVE9Pk-Sx=zXp5w_-C8T-oHqJh0AH8v3cRo7kng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 6:16 PM, Tomasz Figa <t.figa@samsung.com> wrote:

> Calling pinctrl_register() means that the driver is fully initialized
> and might accept pinmux/pinconf requests, so pin groups must be parsed
> before.
>
> This patch fixes this problem by moving device tree parsing before call
> to pinctrl_register(). In addition, this fixes support for hogs on
> pin controllers handled by pinctrl-samsung driver.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Patch applied.

Yours,
Linus Walleij
