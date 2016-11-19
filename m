From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 19 Nov 2016 09:25:33 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.10 (#1)
In-Reply-To: <20161119015838.GG2543@localhost> (Olof Johansson's message of
 "Fri, 18 Nov 2016 17:58:38 -0800")
References: <87poltbwt2.fsf@free-electrons.com>
 <20161119015838.GG2543@localhost>
Message-ID: <877f7zanb6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
 
 On sam., nov. 19 2016, Olof Johansson <olof@lixom.net> wrote:

> Hi,
>
> On Thu, Nov 17, 2016 at 10:50:33PM +0100, Gregory CLEMENT wrote:
>> Hi,
>> 
>> Here is the first pull request for dt for mvebu for v4.10.
>> 
>> I hope being able to send a second part very soon with the series
>> removing all the DT warning.
>> 
>> Gregory
>> 
>> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
>> 
>>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
>> 
>> are available in the git repository at:
>> 
>>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-4.10-1
>> 
>> for you to fetch changes up to cf20c489de6fcef88405d4febef7a078d2053b9e:
>> 
>>   ARM: dt: orion5x: convert ls-chl to FDT (2016-11-07 17:23:34 +0100)
>> 
>> ----------------------------------------------------------------
>> mvebu fixes for 4.10 (part 1)
>> 
>> Most of the commit are pinmux and i2c fix for netgear NASes
>> Fix on a wrong comment about PLL frequency
>> Bigger commit: conversion of on otion5x based board to the device tree
>> 
>> ----------------------------------------------------------------
>> Ashley Hughes (1):
>>       ARM: dt: orion5x: convert ls-chl to FDT
>
> This is a great conversion, but I'd like to see the code handled a
> little differently.
>
> First of all, there's no longer a need to have a config option for 
> MACH_LINKSTATION_LSCHL, as long as ARCH_ORION5X_DT is enabled you'll
> be fine. So you can remove that Kconfig entry alltogether.
>
> Also, there's no need to make the DT addition and the legacy platform
> removal in one commit. It's common that we build up the DT support to the point
> that it's at parity, and then remove the legacy board. That way we also don't
> entangle DT commits with non-DT commits, which can sometimes be a bit of a pain
> (in particular for those who maintain a copy of the DT subdir in another git
> repo).
>
> So, mind respinning with this fixed? Thanks!

OK I am doing it.

Gregory

>
>
> -Olof
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
