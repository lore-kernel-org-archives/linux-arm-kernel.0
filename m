From: olof@lixom.net (Olof Johansson)
Date: Mon, 23 Jul 2018 09:18:36 -0700
Subject: [GIT PULL] am654 changes for v4.19 merge window
In-Reply-To: <20180723130620.qe5xbjcsl3yaawt6@kahuna>
References: <pull-1532152828-552759@atomide.com>
 <20180721220722.43avzbs6ulpsem37@localhost>
 <20180722064041.GM99251@atomide.com> <20180723130620.qe5xbjcsl3yaawt6@kahuna>
Message-ID: <CAOesGMj+ubeTyoXoCxUXuFkupSqJNZyMjLqmqEVNfcREEveU_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 6:06 AM, Nishanth Menon <nm@ti.com> wrote:
> On 06:40-20180722, Tony Lindgren wrote:
>> * Olof Johansson <olof@lixom.net> [180721 22:28]:
>> > On Fri, Jul 20, 2018 at 11:05:16PM -0700, Tony Lindgren wrote:
>> > > From: "Tony Lindgren" <tony@atomide.com>
>> > >
>> > > The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>> > >
>> > >   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>> > >
>> > > are available in the Git repository at:
>> > >
>> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/am654-for-v4.19-signed
>> > >
>> > > for you to fetch changes up to d0a064bec75e20a526c7bc0d626912f2660b6e81:
>> > >
>> > >   arm64: dts: ti: Add support for AM654 EVM base board (2018-07-18 11:48:36 -0700)
>> > >
>> > > ----------------------------------------------------------------
>> > > TI AM654 support for v4.19 merge window
>> > >
>> > > This branch adds initial support for new Texas Instruments AM654
>> > > quad core A53 ARMv8 SoC. It's the first device for TI K3 multicore SoC
>> > > architecture.
>> > >
>> > > Initially only basic devices are configured, support for more devices
>> > > will follow later on. And many of the internal devices familiar from
>> > > earlier TI SoCs should work with existing kernel device drivers.
>> >
>> > I squinted a bit and merged this into next/dt. Might have been a bit cleaner to
>> > split it in a SoC and a DT branch, but either way it's pretty small changes.
>>
>> OK yeah I could have done a separate branch for Kconfig changes.
>
> Thanks a bunch.
>
>>
>> > Should the support be enabled in arm64's defconfig?
>>
>> Yes it should, Nishanth, care to check Linux next once your
>> patches are merged and send a patch for that?
>
> Just checked next-20180723 - Seems to work for me[1]. I was holding off
> the defconfig update to get the driver changes for base to get in. I
> will send a ping on those and if i dont see any response, will send a
> defconfig update by tomorrow.

Feel free to send a patch right after -rc1 to turn on new
options/drivers that have landed in the merge window. If it's just a
few lines we can apply and merge it at that time.


-Olof
