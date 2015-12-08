From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 08 Dec 2015 10:55:53 +0100
Subject: [PATCH 0/5] multi and mvebu v5 defconfig updates
In-Reply-To: <4322870.qyT4ELuZLH@wuerfel> (Arnd Bergmann's message of "Mon, 07
 Dec 2015 23:57:20 +0100")
References: <1449012812-9779-1-git-send-email-andrew@lunn.ch>
 <87610achog.fsf@free-electrons.com> <4322870.qyT4ELuZLH@wuerfel>
Message-ID: <87zixl8dsm.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On lun., d?c. 07 2015, Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 07 December 2015 18:06:07 Gregory CLEMENT wrote:
>> Hi Arnd
>>  
>>  On mer., d?c. 02 2015, Andrew Lunn <andrew@lunn.ch> wrote:
>> 
>> > This patchset updates both multi_v5_defconfig and mvebu_v5_defconfig.
>> > It adds support for Orion5x, now that it is multi-arch, and adds back
>> > DSA and its drivers, which now depends on switchdev.
>> >
>> > Andrew Lunn (5):
>> >   ARM: config: Regenerate multi_v5_defconfig
>> >   ARM: config: Reenable DSA in multi_v5_defconfig
>> >   ARM: config: Add orion5x to multi_v5_defconfig
>> 
>> >   ARM: mvebu: Reenable DSA in mvebu_v5_defconfig
>> >   ARM: mvebu: update v5 defconfig for Orion5x machines
>> 
>> To be sure there won't be a leftover, I applied the last 2 patches, but
>> not the 3 first ones, as for my understanding it is better that it is
>> managed by arm-soc directly.
>> 
>> 
>
> Actually, I'd prefer you to put them in the same branch as the other
> patches. I can easily sort out any merge conflicts when merging the
> branch.

Ok. so I applied the whole series on mvebu/defconfig

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
