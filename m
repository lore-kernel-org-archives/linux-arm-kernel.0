From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 1 Apr 2011 18:04:16 +0100
Subject: [PATCH 1/2] ARM: ELF: Define new core note type for VFP registers
In-Reply-To: <OF6081460F.2C1F93A0-ONC1257865.005D65F7-C1257865.005D9320@de.ibm.com>
References: <1301674888-16842-1-git-send-email-dave.martin@linaro.org>
	<1301674888-16842-2-git-send-email-dave.martin@linaro.org>
	<OF6081460F.2C1F93A0-ONC1257865.005D65F7-C1257865.005D9320@de.ibm.com>
Message-ID: <AANLkTi=0dtPKFH9jYYB8YA4uGx0+BhsjkGouy5nMYMs4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2011 at 6:02 PM, Ulrich Weigand
<Ulrich.Weigand@de.ibm.com> wrote:
> Dave Martin <dave.martin@linaro.org> wrote:
>
>> diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
>> index c3cd875..0b4872d 100644
>> --- a/arch/arm/include/asm/elf.h
>> +++ b/arch/arm/include/asm/elf.h
>> @@ -62,6 +62,8 @@ typedef struct user_fp elf_fpregset_t;
>> ?#define R_ARM_THM_MOVW_ABS_NC ? 47
>> ?#define R_ARM_THM_MOVT_ABS ? 48
>>
>> +#define NT_ARM_VFP ? ? ?0x400
>
> This probably ought to go in include/elf.h, where all the
> other NT_ types are defined ...

OK ... I was wondering since it's arch-specific.

But I can easily move it.

Cheers
---Dave
