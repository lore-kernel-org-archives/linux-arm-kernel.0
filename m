From: james.morse@arm.com (James Morse)
Date: Tue, 08 Dec 2015 10:39:47 +0000
Subject: [PATCH v3 10/10] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
In-Reply-To: <20151201093143.GD21222@amd>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-11-git-send-email-james.morse@arm.com>
 <20151201093143.GD21222@amd>
Message-ID: <5666B373.8070306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 01/12/15 09:31, Pavel Machek wrote:
>> diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
>> index 5faa3ce1fa3a..e75ad7aa268c 100644
>> --- a/arch/arm64/include/asm/suspend.h
>> +++ b/arch/arm64/include/asm/suspend.h
>> @@ -1,3 +1,5 @@
>> +#include <linux/suspend.h>
>> +
>>  #ifndef __ASM_SUSPEND_H
>>  #define __ASM_SUSPEND_H
>>
> 
> Actually... even additional includes should go after the #ifdef
> guards.

Ooops - thanks for spotting that! I will send a fixup.

(I'm expecting to publish a new version if there are newer versions of
the four patches shared with kexec.)


Thanks,

James
