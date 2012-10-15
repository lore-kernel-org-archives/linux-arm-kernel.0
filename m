From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Oct 2012 21:36:26 +0000
Subject: [PATCH] gpio: clps711x: localise <mach/gpio.h> header
In-Reply-To: <20121016004741.485430a1c243795488fbc69b@mail.ru>
References: <1350330020-23240-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdYxQsS4RfCxk3E4GPa+7GK2FeOVfTCps1ZtPC=gSw2a0g@mail.gmail.com>
 <20121016004741.485430a1c243795488fbc69b@mail.ru>
Message-ID: <201210152136.27074.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 October 2012, Alexander Shiyan wrote:
> OK, but since it will be used only in board code, I reintroduce it
> in arch/arm/mach-clps711x/common.h. On my opinion is no reason to
> overload include/linux/*.

Can't the board files just call the gpio functions?

	Arnd
