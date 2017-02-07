From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 07 Feb 2017 15:35:25 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.11 (#3)
In-Reply-To: <3013051.dlCd81dF2f@wuerfel> (Arnd Bergmann's message of "Tue, 07
 Feb 2017 15:14:15 +0100")
References: <87vasvz575.fsf@free-electrons.com> <3013051.dlCd81dF2f@wuerfel>
Message-ID: <87vasmxe4y.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mar., f?vr. 07 2017, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday, January 31, 2017 3:15:10 PM CET Gregory CLEMENT wrote:
>> ----------------------------------------------------------------
>> mvebu dt for 4.11 (part 3)
>> 
>> Add support for Marvell switches with integrated CPUs based on Armada XP
>> 
>> ----------------------------------------------------------------
>> Chris Packham (2):
>>       ARM: dts: mvebu: Add device tree for 98DX3236 SoCs
>>       ARM: dts: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards
>
> Pulled into next/dt, nice to see this getting added! Just for my information,
> do we also support the actual switch driver in Linux, or just the parts that
> are common with Armada?

Currently it is only the common parts with Armada XP. Adding switches
support seems a big task, see the answer of Chris Packham about it:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/476910.html

And also the switch of this family seems different of the one having
support in the dsa subsystem:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/477063.html

Thanks,

Gregory

>
> 	Arnd

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
