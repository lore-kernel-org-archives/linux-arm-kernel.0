From: fu.wei@linaro.org (Fu Wei)
Date: Tue, 24 Jan 2017 13:11:17 +0800
Subject: [PATCH v20 00/17] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <20170123185418.GA961@leverpostej>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170123185418.GA961@leverpostej>
Message-ID: <CADyBb7tT2vWDUrzHV-+W8u8YUWwRTHziU9_ueZK0qkn=YZxHqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

On 24 January 2017 at 02:54, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Jan 18, 2017 at 09:25:24PM +0800, fu.wei at linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>         1. Clean up printk() usage
>>         2. Rename the type macros
>>         3. Rename the PPI enum & enum values
>>         4. Move the type macro and PPI enum into the header file
>>         5. Add new enum for SPIs
>>         6. Rework PPI determination;
>
> I've taken these few patches onto a preliminary/unstable branch [1].

Many thanks for the good news!

>
> I haven't had the time to take a look at the rest of the series yet. I
> intend to go over that tomorrow, picking what I can, and leaving
> feedback for anything that will need rework.

Thanks, I will wait for your feedback, and improve this patchset ASAP.

>
> Thanks,
> Mark.
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arch-timer/updates



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
