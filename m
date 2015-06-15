From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Jun 2015 22:43:21 +0200
Subject: [PATCH] ARM: nomadik: set proper compatible for accelerometer
In-Reply-To: <7hbngg4wss.fsf@deeprootsystems.com>
References: <1433490145-2936-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZ+r3Gd6Drx+PMw280hYO6Nszh4V16E+O-ehawX80DjQg@mail.gmail.com>
 <7hbngg4wss.fsf@deeprootsystems.com>
Message-ID: <CACRpkdYWTYFbz9LEjhKRLjeqoOuYJcrM-rtsMwab6R2rZ-u0+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 9:05 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
>> On Fri, Jun 5, 2015 at 9:42 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>>> Adjust device tree entry to the proper registered compatible
>>> string for LIS3LV02DL.
>>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> Hi ARM SoC people, please apply this directly for -next on the
>>> DT branch. It makes the accelerometer work on the Nomadik.
>>
>> Ping on this.
>
> Sorry, forgot to reply here, but this was applied to next/dt at the same
> time as your other one (ARM64: juno: add GPIO keys).  It's in arm-soc as
> 386f56bb7330 ARM: nomadik: set proper compatible for accelerometer

Ah, I should've checked. Sorry, and thanks!

Yours,
Linus Walleij
