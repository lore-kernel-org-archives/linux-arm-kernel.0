From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 09:53:55 +0200
Subject: [PATCH] pinctrl: sirf: remove sirfsoc_gpio_set_pull function
In-Reply-To: <201210091535.56487.arnd@arndb.de>
References: <201210091535.56487.arnd@arndb.de>
Message-ID: <CACRpkdZE9xjKB_+nY263fBefBy7Hsgo7uxTsHs78xbAr3_N-VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 5:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The prima2 platform advertises needing no mach/gpio.h header file,
> but its pinctrl driver now has a sirfsoc_gpio_set_pull function
> that uses constants defined in arch/arm/mach-prima2/include/mach/gpio.h,
> which fails to build.

Applied to my pinctrl "fixes" branch with Barry's ACK.

Thanks!
Linus Walleij
