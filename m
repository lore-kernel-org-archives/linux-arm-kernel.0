From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 23 Apr 2012 13:19:07 +0200
Subject: [PATCH 5/9] gpio/nomadik: use typesafe __io_address()
In-Reply-To: <20120423091733.GJ24211@n2100.arm.linux.org.uk>
References: <1335172482-27648-1-git-send-email-linus.walleij@stericsson.com>
 <20120423091733.GJ24211@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaBePuSE555c5iN9uF9no+2zHDSYp=sMMmevC9ei6R+kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 11:17 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Apr 23, 2012 at 11:14:42AM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> We were using a custom io_p2v() (physical-to-virtual) translation
>> macro, but with the advent of the cross-platform __io_address()
>> let us try to get rid of this. Inspired by a similar patch by
>> Jonas Aberg.
>
> Is there any point to io_p2v() or __io_address() anymore? ?Won't ioremap()
> do here?

Hey it works, I'll delete the static maps as well and send an updated patch.

Thanks Russell,
Linus Walleij
