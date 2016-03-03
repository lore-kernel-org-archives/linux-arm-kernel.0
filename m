From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Mar 2016 11:35:53 +0100
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.6 (#2)
In-Reply-To: <2820325.orlLQWWEvZ@wuerfel> (Arnd Bergmann's message of "Tue, 01
 Mar 2016 00:00:53 +0100")
References: <87bn73o885.fsf@free-electrons.com> <2820325.orlLQWWEvZ@wuerfel>
Message-ID: <87si07lugm.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mar., mars 01 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 26 February 2016 15:29:46 Gregory CLEMENT wrote:
>> mvebu defconfig for 4.6 (part 2)
>> 
>> enable SRAM support in mvebu_v7_defconfig
>> 
>> 
>
> Merged into next/defconfig.
>
> I see that the SRAM support is not enabled in multi_v7_defconfig, can
> you enable that as well?

Actually it is already selected by CONFIG_ARCH_EXYNOS so there is no
need to add it in multi_v7_defconfig.

Gregory

>
> Thanks!
>
> 	Arnd

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
