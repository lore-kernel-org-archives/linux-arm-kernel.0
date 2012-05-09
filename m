From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 9 May 2012 17:12:52 +0900
Subject: [PATCH 00/02] mach-shmobile: Emma Mobile EV2 - first shot
In-Reply-To: <CAMuHMdUR4mk6ErCj8o2xt2k3vw9RYe5c7MvtQ3q0Xq2sfnV32A@mail.gmail.com>
References: <20120503144645.6390.62303.sendpatchset@w520>
 <201205050722.45500.arnd@arndb.de> <201205052108.03001.rjw@sisk.pl>
 <201205051921.13209.arnd@arndb.de>
 <CAMuHMdUR4mk6ErCj8o2xt2k3vw9RYe5c7MvtQ3q0Xq2sfnV32A@mail.gmail.com>
Message-ID: <CANqRtoTamkCfu0yHiF8oGXdLKDjSxhBO-GqPDJ00Ejw5LkSqkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 4:57 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sat, May 5, 2012 at 9:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Saturday 05 May 2012, Rafael J. Wysocki wrote:
>>> Now, if you insist on us having a separate mach- directory for every platform
>>> (SoC), we can do that I think, but then we should start with splitting up the
>>> existing mach-shmobile into a number of SoC-specific directories rather than
>>> adding new mach- directories for random new parts, because that goes against
>>> our development history to date, which is important too IMHO.
>>
>> All the chips in there so far share a common ancestry and they all use a
>> significant subset of the same drivers shared with arch/sh: i2c-sh_mobile,
>> sh-dma-engine, sh_cmt, sh-sci, sh_tmu, intc, pfc and sh_clk. AFAICT, this one
>> uses none of those and apparently was developed by NEC before the merger with
>> Renesas.
>
> Ah, I didn't know NEC joined Renesas, but Wikipedia proves you're right.

Actually, for those of you who care about details - NEC Electronics
and Renesas merged into Renesas Electronics. Other parts of NEC are
still around as usual.

> So, any similarities with the MIPS-based NEC EMMA SOCs, i.e. more code to
> share?

That would be very interested to know. I've grepped the kernel tree
for existing code matching Uart, STI and GPIO but nothing so far. Does
anyone know where I can find docs for the MIPS based ones?

Good news is that documentation for Emma Mobile EV2 and Emma Mobile
1-S can be downloaded from renesas.com.

Cheers,

/ magnus
