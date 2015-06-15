From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 15 Jun 2015 12:05:23 -0700
Subject: [PATCH] ARM: nomadik: set proper compatible for accelerometer
In-Reply-To: <CACRpkdZ+r3Gd6Drx+PMw280hYO6Nszh4V16E+O-ehawX80DjQg@mail.gmail.com>
 (Linus Walleij's message of "Mon, 15 Jun 2015 09:58:30 +0200")
References: <1433490145-2936-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZ+r3Gd6Drx+PMw280hYO6Nszh4V16E+O-ehawX80DjQg@mail.gmail.com>
Message-ID: <7hbngg4wss.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Fri, Jun 5, 2015 at 9:42 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> Adjust device tree entry to the proper registered compatible
>> string for LIS3LV02DL.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Hi ARM SoC people, please apply this directly for -next on the
>> DT branch. It makes the accelerometer work on the Nomadik.
>
> Ping on this.

Sorry, forgot to reply here, but this was applied to next/dt at the same
time as your other one (ARM64: juno: add GPIO keys).  It's in arm-soc as
386f56bb7330 ARM: nomadik: set proper compatible for accelerometer

Thanks,

Kevin



    
