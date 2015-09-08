From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Sep 2015 16:11:42 +0200
Subject: [PATCH] pinctrl: core: Warn about NULL gpio_chip in
 pinctrl_ready_for_gpio_range()
In-Reply-To: <1441301670-6498-1-git-send-email-tony@atomide.com>
References: <1441301670-6498-1-git-send-email-tony@atomide.com>
Message-ID: <CACRpkdbQBt_p74ke3TV94gZ5wa=87th+f5jOLNSZFFhFbn3NEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 3, 2015 at 7:34 PM, Tony Lindgren <tony@atomide.com> wrote:

> If the gpio driver is confused about the numbers for gpio-ranges,
> pinctrl_ready_for_gpio_range() may get called with invalid GPIO
> causing a NULL pointer exception. Let's instead provide a warning
> that allows fixing the problem and return with error.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied for fixes.

Yours,
Linus Walleij
