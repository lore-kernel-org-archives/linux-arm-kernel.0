From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 16 May 2012 14:57:09 +0800
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205152135.26759.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515173909.383a0d8a@skate> <201205151626.49173.arnd@arndb.de>
 <201205152135.26759.arnd@arndb.de>
Message-ID: <CAN1soZzzPXXcgoE_8a_gD8WVmMHKDdP_MW3QFR-4W13-z+J+VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 5:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 15 May 2012, Arnd Bergmann wrote:
>
>> Another way would be to reorganize those directories upfront:
>>
>> plat-orion -> mach-orion
>> mach-*/*.c -> mach/orion/*/*.c
>> mach-*/include/mach/* -> mach-orion/include/mach/*.h
>>
>> and then go from there. The differences between the headers are fairly
>> small already, so that should be manageable.
>
> Actually we could do a trivial move of all files into one directory at any
> time, e.g. at the end of the merge window, to minimize conflicts with
> other patches.
>
> This is a semi-automated move of all plat-orion based machines into
> a single mach-orion directory, and we could of course add the new stuff
> in there as well.

mach-orion is better than mach-armada. Armada is just a Logo, not a
silicon family.
Silicons with ARMv5/v6/v7 core are all marked with Armada Logo.

By the way, silicons in mach-pxa and mach-mmp are also named Armada.

Regards
Haojian
