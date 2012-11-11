From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Nov 2012 19:07:57 +0100
Subject: [PATCH V2 4/5] pinctrl: SPEAr: Add gpio ranges support
In-Reply-To: <3b2f9fa0864f1f736e24ee0dbc081cd9a79b7468.1351330569.git.viresh.kumar@linaro.org>
References: <cover.1351330569.git.viresh.kumar@linaro.org>
 <3b2f9fa0864f1f736e24ee0dbc081cd9a79b7468.1351330569.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdbb6Ow_g-K_EJyr9preD9JwF7d8JX9iptSuXcSWgP+Z0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 27, 2012 at 11:51 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Most of SPEAr SoCs, which support pinctrl, can configure & use pads as gpio.
> This patch gpio enable support for SPEAr pinctrl drivers.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Now, as I have brought in v3.7-rc5, I have applied this patch
that depended on the fixes.

Yours,
Linus Walleij
