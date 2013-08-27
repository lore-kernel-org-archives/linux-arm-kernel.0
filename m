From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Aug 2013 05:16:23 +0200
Subject: what about mach-shark?
In-Reply-To: <20130826190646.GG6617@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1107041545480.14596@xanadu.home>
 <CACRpkdb2QQEAt_bpVv9sifEuDfs_8XdDbUtQ9R+cXA-vBWMKmA@mail.gmail.com>
 <20130826190646.GG6617@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbrvVsSWFGo1QjDekZRc1svKaOsFpxqQJ0TKHtU2+XgKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 9:06 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 26, 2013 at 09:04:05PM +0200, Linus Walleij wrote:
>> On Mon, Jul 4, 2011 at 10:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>>
>> > Is this used?
>>
>> This still goes unanswered after two years.
>>
>> Alexander, are you compiling and booting recent kernels on the Shark?
>>
>> I recently had a dream to convert some platforms and eventually
>> all of the arch/arm machines to GENERIC_CLOCKEVENTS and
>
> You're not going to achieve that pipedream.  Really.  There are platforms
> still around which don't have enough timers to be able to do anything but
> periodic interrupts at a fixed rate - with nothing available as a clock
> source other than the kernel jiffy counter incremented by that periodic
> interrupt (which would create a circular dependency.)

Yes, I guess I will run into them... But I guess it doesn't hurt to
convert over the remaining machines that can actually do this
the right way.

Yours,
Linus Walleij
