From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Feb 2014 21:18:22 +0100
Subject: [PATCH] pinctrl: single: add low powr mode support
In-Reply-To: <1390893644-3458-1-git-send-email-chao.xie@marvell.com>
References: <1390893644-3458-1-git-send-email-chao.xie@marvell.com>
Message-ID: <CACRpkdaMDRKXgMjtbnV8hhhuKYbNzSG1U7LYnD5WEDaUE4z8pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 8:20 AM, Chao Xie <chao.xie@marvell.com> wrote:

> From: Chao Xie <chao.xie@marvell.com>
>
> For some silicons, the pin configuration register can control
> the output of the pin when the pad including the pin enter
> low power mode.
> For example, the pin can be "Drive 1", "Drive 0", "Float" when
> the pad including the pin enter low power mode.
> It is very useful when you want to control the power leakeage
> when the SOC enter low power mode, and can save more power for
> the low power mode.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

Looks similar to the other pin config stuff, patch applied
unless Tony protests.

Yours,
Linus Walleij
