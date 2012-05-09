From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 13:48:30 +0000
Subject: ARM: ux500: !CONFIG_OF build error drivers/gpio/gpio-nomadik.c
In-Reply-To: <CACRpkdYa1PcLjOFemsE_LabYqyKhF+wfUCTCCsTpd0=2-gQZWg@mail.gmail.com>
References: <201205071551.17327.arnd@arndb.de>
 <CACRpkdYa1PcLjOFemsE_LabYqyKhF+wfUCTCCsTpd0=2-gQZWg@mail.gmail.com>
Message-ID: <201205091348.30765.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Linus Walleij wrote:
> Sure! However I'm floating some patch moving gpio/gpio-nomadik.c to
> pinctrl/pinctrl-nomadik.c so prepare to handle that merge conflict when
> pulling that in.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

In that case, would it be easier if you apply the patch on your branch?

	Arnd
