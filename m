From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 30 Aug 2017 10:21:46 +0200
Subject: [PATCH 0/2] arm64: renesas: Add support for R-Car V3M
In-Reply-To: <20170830072644.GI10398@verge.net.au>
References: <1503665810-13945-1-git-send-email-geert+renesas@glider.be>
 <20170828074453.GA22421@verge.net.au> <20170830072644.GI10398@verge.net.au>
Message-ID: <CAMuHMdWvRBH8ZNgQKDGS3Z41BN7_o_H=hN5aGdbK44YT8rusXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Aug 30, 2017 at 9:26 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Aug 28, 2017 at 09:44:54AM +0200, Simon Horman wrote:
>> On Fri, Aug 25, 2017 at 02:56:48PM +0200, Geert Uytterhoeven wrote:
>> > This patch series adds initial R-Car V3M infrastructure:
>> >   1. SoC DT bindings,
>> >   2. Main Kconfig symbol.
>> >
>> > Both follow the example set by R-Car D3 aka r8a77995, using 5-digit instead
>> > of 4-digit part numbers.
>> > Alternatively, we could stick to 4-digit part numbers if the fifth digit is
>> > a zero.
>> >
>> > For your convenience, a branch with more preliminary work (thanks Sergei,
>> > for posting the clock driver!) for testing on v3m/eagle is also available
>> > in the topic/r8a77970-integration branch of my renesas-drivers git
>> > repository at
>> > git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
>> >
>> > Thanks for your comments!
>>
>> This looks good to me.
>>
>> I am in favour of using the 5-digit scheme for all new R-Car Gen 3 SoCs
>> as it seems the safest option with regards to as yet unknown (to me) part
>> numbers.
>
> Geert, any objections to me applying these?
> I'm happy to wait longer if you prefer.

It would be good to have an ack from Rob.
No need to hurry.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
