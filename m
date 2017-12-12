From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Dec 2017 00:08:22 +0100
Subject: [PATCH] ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register
In-Reply-To: <874lovg095.fsf@belgarion.home>
References: <E1eOTFj-0008MB-Fj@rmk-PC.armlinux.org.uk>
 <874lovg095.fsf@belgarion.home>
Message-ID: <CACRpkdY+Nggxv9wVf=EeQLBwz6fdZkN7U0cGt6+e8hnrb6jS6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 9:27 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Russell King <rmk+kernel@armlinux.org.uk> writes:
>
>> Add a gpio driver for the lubbock miscellaneous write IO register so we
>> can take advantage of subsystems modelled around gpiolib, rather than
>> having to provide platform specific callbacks.
>>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> Hi Russell and Linux,
>
> It looks certainly good to me. It's unfortunate in the current status of
> linux-next I have, gpio-reg.c seems broken (that one is for Linus in [1] and
> [2]), and therefore I can't test it live.

OK I have applied a patch fixing it, sorry for not preparing the trees and
pushing it out quicker :(

> Nonetheless, do you want me to carry it through the pxa tree or do you want to
> keep it through your tree ?

By all means carry it in the PXA tree.

Yours,
Linus Walleij
