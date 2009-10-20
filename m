From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 21 Oct 2009 03:43:44 +0800
Subject: collie and SA1100 patches
In-Reply-To: <4ADDFADB.8090808@gmx.de>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<4ADDFADB.8090808@gmx.de>
Message-ID: <f17812d70910201243k6b9d1856g26becc89ff551994@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2009 at 2:00 AM, Thomas Kunze <thommycheck@gmx.de> wrote:
> Hi,
>
> what is the status of this patchset?
> The patchset is available via git at:
> http://git.linuxtogo.org/?p=thesing/collie.git;a=shortlog;h=refs/heads/for-lak
>
> The branch is based on 2.6.32-rc5. Please tell me if I should rebase on sth.
> else.

This patchset looks OK to me. I'm willing to see such changes being
made to pxa2xx-based zaurus as well.

Russell,

Are you interested to merge this?

>
> Regards,
> Thomas
>>
>> Hi all!
>> ? This patchset implements prober power management for collie. To archieve
>> this
>> some bugs were fixed and gpiolib-support was added to the ucb1x00 driver.
>> Please tell me if I should CC some other people or lists.
>>
>> Regards,
>> Thomas
>>
>> Statistics:
>> ?arch/arm/mach-sa1100/collie.c ? ? ? ? ? ? ?| ? 79 +++++-
>> ?arch/arm/mach-sa1100/include/mach/collie.h | ? 77 +++---
>> ?arch/arm/mach-sa1100/include/mach/gpio.h ? | ? 19 +-
>> ?arch/arm/mach-sa1100/include/mach/mcp.h ? ?| ? ?1 +
>> ?drivers/leds/leds-locomo.c ? ? ? ? ? ? ? ? | ? ?2 +-
>> ?drivers/mfd/mcp-core.c ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
>> ?drivers/mfd/mcp-sa11x0.c ? ? ? ? ? ? ? ? ? | ? ?3 +-
>> ?drivers/mfd/ucb1x00-assabet.c ? ? ? ? ? ? ?| ? ?2 +-
>> ?drivers/mfd/ucb1x00-core.c ? ? ? ? ? ? ? ? | ? 89 ++++++-
>> ?drivers/mfd/ucb1x00-ts.c ? ? ? ? ? ? ? ? ? | ? ?2 +-
>> ?drivers/power/Kconfig ? ? ? ? ? ? ? ? ? ? ?| ? ?7 +
>> ?drivers/power/Makefile ? ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?drivers/power/collie_battery.c ? ? ? ? ? ? | ?418
>> ++++++++++++++++++++++++++++
>> ?{drivers => include/linux}/mfd/mcp.h ? ? ? | ? ?3 +
>> ?{drivers => include/linux}/mfd/ucb1x00.h ? | ? ?7 +-
>> ?15 files changed, 649 insertions(+), 63 deletions(-)
>> ?create mode 100644 drivers/power/collie_battery.c
>> ?rename {drivers => include/linux}/mfd/mcp.h (97%)
>> ?rename {drivers => include/linux}/mfd/ucb1x00.h (98%)
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
