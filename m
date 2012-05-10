From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 May 2012 13:30:16 +0200
Subject: ARM: ux500: !CONFIG_OF build error drivers/gpio/gpio-nomadik.c
In-Reply-To: <201205091348.30765.arnd@arndb.de>
References: <201205071551.17327.arnd@arndb.de>
 <CACRpkdYa1PcLjOFemsE_LabYqyKhF+wfUCTCCsTpd0=2-gQZWg@mail.gmail.com>
 <201205091348.30765.arnd@arndb.de>
Message-ID: <CACRpkdbM+Fxy=fy4guCrnXASX8xn_oq2a5KEdsZ_6oSyyg=9PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 3:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 09 May 2012, Linus Walleij wrote:
>> Sure! However I'm floating some patch moving gpio/gpio-nomadik.c to
>> pinctrl/pinctrl-nomadik.c so prepare to handle that merge conflict when
>> pulling that in.
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> In that case, would it be easier if you apply the patch on your branch?

OK I've applied it! I have some review comments to address
I think then it'll be ready for a pull request.

Linus
