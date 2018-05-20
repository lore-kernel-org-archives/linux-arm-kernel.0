From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 20 May 2018 19:17:04 +0300
Subject: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
In-Reply-To: <3505791.x6nWYTo8eb@z50>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <5456625.lDWjtgZygK@z50>
 <CAHp75Ved2nw1JKnXT2Jxnw4XLsby1eVJU6cfBjE2sp4LP4Kwmg@mail.gmail.com>
 <3505791.x6nWYTo8eb@z50>
Message-ID: <CAHp75Vdp5A58JMTf8vaET84QEzzZ_T7eKLUYfWV9qpWt5ptYCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 20, 2018 at 6:37 PM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> On Sunday, May 20, 2018 4:44:31 PM CEST Andy Shevchenko wrote:

>> Though, I completely dislike "rdy" name of GPIO. Where is it documented?
>
> No documentation files for Amstrad Delta nor for its NAND driver specifically
> exist under Documentation/. However, there exist some for generic GPIO NAND
> driver where the pin name "rdy" is used explicitly:
> Documentation/driver-api/gpio/drivers-on-gpio.rst
> Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
> You can find that mnemonic used across drivers/mtd/nand/, standalone or as a
> suffix, including the Amstrad Delta NAND driver before the change discussed.

> To be honest, I don't like it much either, but I'm just using it instead of
> inventing something new.

OK, that's what I was looking for. Since it's already in use and
documented, then it's fine for me.

-- 
With Best Regards,
Andy Shevchenko
