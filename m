From: gump.yang@gmail.com (=?UTF-8?B?5p2o5Z+O?=)
Date: Mon, 15 Feb 2010 08:58:28 +0800
Subject: apply chip ID
In-Reply-To: <20100214194046.GA11315@n2100.arm.linux.org.uk>
References: <d4d4c7ef1002140814x5c406afaq7f60dc584e389348@mail.gmail.com>
	<20100214194046.GA11315@n2100.arm.linux.org.uk>
Message-ID: <d4d4c7ef1002141658x789730b8naaf38b04811559dd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Feb 15, 2010 at 12:14:08AM +0800, ?? wrote:
>> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
>> index 07b976d..629b858 100644
>> --- a/arch/arm/tools/mach-types
>> +++ b/arch/arm/tools/mach-types
>> @@ -2635,3 +2635,4 @@ hw90240                 MACH_HW90240            HW90240                 2648
>> dm365_leopard         MACH_DM365_LEOPARD      DM365_LEOPARD           2649
>> mityomapl138          MACH_MITYOMAPL138       MITYOMAPL138            2650
>> scat110                       MACH_SCAT110            SCAT110                 2651
>> +ak780x                       MACH_AK780X             AK780X                  2557
>> +ak880x                       MACH_AK880X             AK880X                  2558
>
> This file is periodically replaced; as such taking patches for the file is
> senseless.
>
> Moreover, your two additions refer to a number which is already allocated
> and in use for bcmring_evm_jazz and bcmring_sp - you can not use these
> numbers.
>

Hello Russell, sorry, i mean that get to obtain two ID. so I modify the patch.
