From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Jul 2013 17:26:32 +0200
Subject: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
In-Reply-To: <798C2D39-EE8E-4C73-A98D-63231375599C@collabora.co.uk>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
 <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
 <51F633AE.8090308@collabora.co.uk>
 <alpine.DEB.2.02.1307290943000.30864@utopia.booyaka.com>
 <D135FD6D-D4B6-4237-9866-4FFED36C03CD@collabora.co.uk>
 <CACRpkdZ1E9zC_yyK=UkJSejCwb_k7sYfhNgH5NASZ8Nf-qt2KA@mail.gmail.com>
 <798C2D39-EE8E-4C73-A98D-63231375599C@collabora.co.uk>
Message-ID: <CACRpkdakWmF4cgAXQMCP04cY+QmqXT9puxmmZ3G4PB9Wj_p8Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 2:40 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> On 29/07/2013, at 13:43, Linus Walleij <linus.walleij@linaro.org> wrote:

>> So I'm drafting an RFC to indicate how I think this should
>> be solved.
>>
>
> Great, I hope we can finally have a good solution for this long standing issue.

I have sent out this RFC patch, subject:
"RFC: interrupt consistency check for OF GPIO IRQs"

Please review the general concept of this patch and whether
it would help solving the OMAP situation for v3.12.

The patch as it stands will not work, and I cannot create a
proper test here because I have no test target system
(I am technically on vacation), but I will get to it as I get back.

And folks: you shouldn't feel bad about this. The problem is
not OMAPs at all, the problem has been there all the time
and we have discussed it for some time, it just happened that
OMAP was the first system that tried to come up with some
kind of fix for it, and for this you should be thanked, even if
we need to take another path in the end.

Yours,
Linus Walleij
