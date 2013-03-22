From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Mar 2013 20:22:48 +0100
Subject: Integrator PCI base dilemma
In-Reply-To: <20130322103740.GW4977@n2100.arm.linux.org.uk>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <201303211302.19058.arnd@arndb.de>
 <20130321234004.GV4977@n2100.arm.linux.org.uk>
 <201303220948.28092.arnd@arndb.de>
 <20130322103740.GW4977@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdb5Q+EtM0GGaLFNUj1A12zVrcyUxzRvfEOpcH4-pVuasA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 11:37 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> On Fri, Mar 22, 2013 at 09:48:27AM +0000, Arnd Bergmann wrote:
>> Yes, I was assuming that Linus would keep Integrator/AP working since that is
>> what he uses.
>
> It's entirely possible that Linus doesn't use a VGA card with Integrator/AP
> if Linus is not using MILO - because MILO was the only boot loader for
> that platform which had an x86 emulator built in to run the VGA BIOS to
> initialize the VGA card.

You are right, or, well, I have had an S3 VGA card plugged in and been
scratching my head wondering how I should get the damned thing to
work.

Now I *know* there is not really a way for me to make this work
with the kernel only.

> There are two boot loaders I'm aware of which are capable of doing this,
> and those are MILO and my boot loader for Footbridge platforms (which,
> incidentally, now runs ATA card BIOSes too complete with input support
> and can push out the VGA output via serial and accept keypresses via
> serial) - and that doesn't work on Integrator/AP.

I'm on U-boot for this thing, I wonder if that can do x86
emulation to initialize VGA card. I guess I'm about to learn.

Yours,
Linus Walleij
