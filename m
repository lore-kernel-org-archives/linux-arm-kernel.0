From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 5 Feb 2016 10:31:20 -0800
Subject: [PATCH] ARM: keystone: remove redundant depends on
 ARM_PATCH_PHYS_VIRT
In-Reply-To: <CAK7LNAQQ-fT38pg2S7QmbuZ3dmpy6qE6viQD87ec=QMNnUx6zQ@mail.gmail.com>
References: <1454694041-14990-1-git-send-email-yamada.masahiro@socionext.com>
 <56B4E257.5050308@oracle.com>
 <CAK7LNAQQ-fT38pg2S7QmbuZ3dmpy6qE6viQD87ec=QMNnUx6zQ@mail.gmail.com>
Message-ID: <56B4EA78.6050203@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/5/2016 10:13 AM, Masahiro Yamada wrote:
> 2016-02-06 2:56 GMT+09:00 santosh shilimkar <santosh.shilimkar@oracle.com>:
>> On 2/5/2016 9:40 AM, Masahiro Yamada wrote:
>>>
>>> KeyStone is Multi-platform.  ARM_PATCH_PHYS_VIRT is already select'ed
>>> by ARCH_MULTIPLATFORM.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>> There is also Keystone config so its nit redundant as you think.
>>
>> P.S: arch/arm/configs/keystone_defconfig
>>
>
> It *is* redundant.
>
> keystone_defconfig also creates Multiplatform configuration.
>
Fair enough. Should I checked it.
For patch,
Acked-by: Santosh Shilimkar<ssantosh@kernel.org>
