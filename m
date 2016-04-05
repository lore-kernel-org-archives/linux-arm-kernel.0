From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 5 Apr 2016 11:14:06 +0900
Subject: [PATCH] ARM: keystone: remove redundant depends on
 ARM_PATCH_PHYS_VIRT
In-Reply-To: <56B4EA78.6050203@oracle.com>
References: <1454694041-14990-1-git-send-email-yamada.masahiro@socionext.com>
 <56B4E257.5050308@oracle.com>
 <CAK7LNAQQ-fT38pg2S7QmbuZ3dmpy6qE6viQD87ec=QMNnUx6zQ@mail.gmail.com>
 <56B4EA78.6050203@oracle.com>
Message-ID: <CAK7LNAR+kU4F-rLDOpf_772am3gS86uizHZG4tZpPSCpyjdR4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-06 3:31 GMT+09:00 santosh shilimkar <santosh.shilimkar@oracle.com>:
> On 2/5/2016 10:13 AM, Masahiro Yamada wrote:
>>
>> 2016-02-06 2:56 GMT+09:00 santosh shilimkar
>> <santosh.shilimkar@oracle.com>:
>>>
>>> On 2/5/2016 9:40 AM, Masahiro Yamada wrote:
>>>>
>>>>
>>>> KeyStone is Multi-platform.  ARM_PATCH_PHYS_VIRT is already select'ed
>>>> by ARCH_MULTIPLATFORM.
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>>
>>> There is also Keystone config so its nit redundant as you think.
>>>
>>> P.S: arch/arm/configs/keystone_defconfig
>>>
>>
>> It *is* redundant.
>>
>> keystone_defconfig also creates Multiplatform configuration.
>>
> Fair enough. Should I checked it.
> For patch,
> Acked-by: Santosh Shilimkar<ssantosh@kernel.org>
>

If it is OK with you, please apply this patch.


-- 
Best Regards
Masahiro Yamada
