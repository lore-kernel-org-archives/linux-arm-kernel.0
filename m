From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 14 Aug 2014 19:17:44 +0530
Subject: [PATCH v7 07/11] arm64: mm: Implement 4 levels of translation
 tables
In-Reply-To: <20140814125823.GD9039@arm.com>
References: <CAGoO6fLT6B_vx+Wtm6bKHD6YkjQcM8f=deD7SDP3BR_uC+1c5w@mail.gmail.com>
 <ACF42928-55EE-4466-B217-982839BB98C4@gmail.com>
 <53D7AD7A.8050706@amd.com>
 <9DF712F2-52EB-412B-9E6F-41FC8212AE1F@gmail.com>
 <CAFpQJXU_8HTaL5s+gyZKA7F6HS_jeAfOrEwahEe0P-EKo1FaHA@mail.gmail.com>
 <20140814125823.GD9039@arm.com>
Message-ID: <CAFpQJXVHLKSoOJZ_bZd2ZxTJGZaa=0GxOn9sg0rBY7zrseSv9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 6:28 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Aug 14, 2014 at 12:42:12PM +0100, Ganapatrao Kulkarni wrote:
>> IMHO, the Macro MAX_PHYSMEM_BITS needs to be set to 48 in file
>> arch/arm64/include/asm/sparsemem.h
>>
>> with 40 bit set, for RAM address beyond 40 bit,  seeeing below warning message.
>> WARNING: CPU: 0 PID: 0 at mm/sparse.c:164
>> mminit_validate_memmodel_limits+0xf8/0x118()
>
> I agree. Would you mind sending a patch?
Sure I will send you the patch.
>
> Thanks.
>
> --
> Catalin

thanks
Ganapat
