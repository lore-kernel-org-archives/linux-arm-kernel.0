From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 16 Aug 2013 21:54:44 +0200
Subject: [RFC v1 4/5] ARM: mvebu: add Armada 1500 and Sony NSZ-GS7 device
 tree files
In-Reply-To: <20130816195046.GU13964@titan.lakedaemon.net>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130816195046.GU13964@titan.lakedaemon.net>
Message-ID: <520E8384.2010209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2013 09:50 PM, Jason Cooper wrote:
> On Fri, Aug 16, 2013 at 09:41:37PM +0200, Sebastian Hesselbarth wrote:
>> This adds very basic device tree files for the Marvell Armada 1500 SoC
>> and the Sony NSZ-GS7 GoogleTV board. Currently, SoC only has nodes for
>> cpus, some clocks, l2 cache controller, local timer, apb timers, uart,
>> and interrupt controllers.
[...]
>> ---
>>   arch/arm/boot/dts/Makefile                     |    3 +-
>>   arch/arm/boot/dts/armada-1500-sony-nsz-gs7.dts |   29 +++
>>   arch/arm/boot/dts/armada-1500.dtsi             |  225 ++++++++++++++++++++++++
>>   3 files changed, 256 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/boot/dts/armada-1500-sony-nsz-gs7.dts
>>   create mode 100644 arch/arm/boot/dts/armada-1500.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 641b3c9..3186904 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -103,7 +103,8 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>>   	armada-370-rd.dtb \
>>   	armada-xp-db.dtb \
>>   	armada-xp-gp.dtb \
>> -	armada-xp-openblocks-ax3-4.dtb
>> +	armada-xp-openblocks-ax3-4.dtb \
>> +	armada-1500-sony-nsz-gs7.dtb
>
> alphabetical.

Dammit, true! ;)

> And now I need to pick up a googleTV...

Jep, go shopping :)

Unfortunately, I (again) put too many people in Cc and all 5 patches
are stuck waiting for moderator approval. With 5 DT maintainers it isn't
easy to get those though to MLs.

Sebastian
