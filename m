From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Sep 2012 13:32:49 -0700
Subject: [PATCH v9 06/13] ARM: SoC: convert MSM SMP to SoC descriptor
In-Reply-To: <20120912162651.GA22904@codeaurora.org>
References: <1347461906-13527-1-git-send-email-arnd@arndb.de>
 <1347461906-13527-7-git-send-email-arnd@arndb.de>
 <20120912162651.GA22904@codeaurora.org>
Message-ID: <5050F171.2060704@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/12 09:26, David Brown wrote:
> On Wed, Sep 12, 2012 at 04:58:19PM +0200, Arnd Bergmann wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Convert MSM SMP platforms to use the SoC descriptor to provide
>> their SMP and CPU hotplug operations.
>>
>> Cc: David Brown <davidb@codeaurora.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/arm/mach-msm/board-msm8960.c |    3 +++
>>  arch/arm/mach-msm/board-msm8x60.c |    7 +++++++
> Stephen Boyd recently sent out a patch series that remove the non-DT
> support for these two targets, which naturally generates a bunch of
> conflicts.
>
> I'm about to send out a pull request including these changes, and
> after that, I'll rework this patch for the new board files, and give
> it a try.

It would also be nice if you used the common.h file instead of adding a
core.h. common.h is a new file in the patch series you mention.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
