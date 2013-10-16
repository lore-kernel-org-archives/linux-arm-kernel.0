From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 16 Oct 2013 10:30:49 -0400
Subject: [RFC PATCH 1/4] ARM64: Add Kconfig option to enable Big Endian
 kernel
In-Reply-To: <525E36F8.6080206@linaro.org>
References: <1381494135-15085-1-git-send-email-ankit.jindal@linaro.org>
 <1381494135-15085-2-git-send-email-ankit.jindal@linaro.org>
 <525D84CF.4060705@codeaurora.org> <525E36F8.6080206@linaro.org>
Message-ID: <525EA319.5030807@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tushar,

On 10/16/2013 02:49 AM, Tushar Jagad wrote:
> Hi Christopher,
> 
> On 10/15/2013 11:39 PM, Christopher Covington wrote:
> 
>> What makes a board properly built and how can a user determine whether their
>> board is?
> 
> As of now this flag assumes that the bootloader is in LE mode. It is left to
> the kernel to switch to BE mode. This flag makes the kernel set necessary
> flags in SCTLR registers on entry.

I would suggest that you say that instead. The existing wording makes it sound
strictly hardware related.

>>
>>> +                                                [...] and your board
>>> +          port must properly enable any big-endian related features
>>> +          of your chipset/board/processor.
>>
>> What is a board port for arm64?
> 
> This is a generic patch for the architecture. Each driver needs to make
> necessary changes keeping the kernel endianness in mind. We have tested these
> patches on our X-Gene platform.

Perhaps it would be clearer to say "drivers" instead of "board ports" then. I
thought the comment was referring to code inside mach-* or plat-* directories.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
