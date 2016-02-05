From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 6 Feb 2016 03:13:37 +0900
Subject: [PATCH] ARM: keystone: remove redundant depends on
 ARM_PATCH_PHYS_VIRT
In-Reply-To: <56B4E257.5050308@oracle.com>
References: <1454694041-14990-1-git-send-email-yamada.masahiro@socionext.com>
 <56B4E257.5050308@oracle.com>
Message-ID: <CAK7LNAQQ-fT38pg2S7QmbuZ3dmpy6qE6viQD87ec=QMNnUx6zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-06 2:56 GMT+09:00 santosh shilimkar <santosh.shilimkar@oracle.com>:
> On 2/5/2016 9:40 AM, Masahiro Yamada wrote:
>>
>> KeyStone is Multi-platform.  ARM_PATCH_PHYS_VIRT is already select'ed
>> by ARCH_MULTIPLATFORM.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
> There is also Keystone config so its nit redundant as you think.
>
> P.S: arch/arm/configs/keystone_defconfig
>

It *is* redundant.

keystone_defconfig also creates Multiplatform configuration.


-- 
Best Regards
Masahiro Yamada
