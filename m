From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Dec 2012 17:56:24 +0100
Subject: [PATCH 0/2] gpio: dt: add gpio-export support
In-Reply-To: <20121124184846.GC4398@game.jcrosoft.org>
References: <20121121101259.GQ4398@game.jcrosoft.org>
 <CACRpkdZN12bsx_YgXFfOPZzebjNG6fbwF9y=vNhzzyye-jsQUg@mail.gmail.com>
 <20121124184846.GC4398@game.jcrosoft.org>
Message-ID: <CACRpkdbMNxFAYZBVai4=GjMioRhe6odhFrPsM3Tx_p6gBA357g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 24, 2012 at 7:48 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 15:43 Wed 21 Nov     , Linus Walleij wrote:
>> On Wed, Nov 21, 2012 at 11:12 AM, Jean-Christophe PLAGNIOL-VILLARD
>> <plagnioj@jcrosoft.com> wrote:
>>
>> > HI,
>> >
>> >         This patch serie add the support of gpio-export to DT
>> >
>> >         This also extend to gpio_export with the possibility to specify a name
>> >         for the gpio.
>> >         When you support different hardware you do not need to knwon which gpio
>> >         is used at application level just you have it
>> >
>> >         based on next-20121115 tested on AT91 Animeo IP
>> >
>> >   gpiolib-of: ad gpio-export support (2012-11-19 20:36:03 +0800)
>>
>> OK so this is definately Grant territory, I'm just a novice in DT land...
>> Grant can you look at this?
> Grant any comment?

Yeah, ping on Grant :-)

He did come back online last week but will need time to catch up.

Yours,
Linus Walleij
