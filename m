From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Oct 2013 11:10:20 +0200
Subject: [PATCH] ARM: ux500: u8500_defconfig: add missing cpuidle option
In-Reply-To: <1380540996-18521-1-git-send-email-daniel.lezcano@linaro.org>
References: <1380540996-18521-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CACRpkdZ856omBFmLTQoPH_QkobkYj4tAgvHEmVZzA8+SOvYwRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 1:36 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> With the commit d3f2950f2adeea3da0317e952914b59adaa4cdb3, the option
> ARM_U8500_CPUIDLE was added to the Kconfig but not reflected in the
> default config file, hence the cpuidle driver is no longer enabled
> since this commit.
>
> Enable it again by adding the missing option in the default config file.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Patch applied. Sorry for taking so long...

Yours,
Linus Walleij
