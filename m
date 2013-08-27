From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 27 Aug 2013 09:07:34 -0700
Subject: arm-soc: Xilinx Zynq cleanups for v3.12 v2
In-Reply-To: <CAHTX3dLYC_pxNFSUYEyYA3dVXBotMOYA6W=LEgsBTX4Ggt5rHg@mail.gmail.com>
 (Michal Simek's message of "Tue, 27 Aug 2013 17:11:58 +0200")
References: <52130428.3010205@monstr.eu>
 <CAHTX3dLYC_pxNFSUYEyYA3dVXBotMOYA6W=LEgsBTX4Ggt5rHg@mail.gmail.com>
Message-ID: <87mwo3w20p.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal Simek <monstr@monstr.eu> writes:

> Hi guys,
>
> any update on this?

Oops, looks like I forgot to reply, but this was pulled into
next/cleanup last week.

Kevin


>
> 2013/8/20 Michal Simek <monstr@monstr.eu>
>
>> Hi Arnd, Kevin and Olof,
>>
>> This is the second pull request because Kevin wanted to remove clk changes
>> and send them through Mike's clk tree.
>> Please pull these cleanup patches to your tree.
>>
>> Thanks,
>> Michal
>>
>> The following changes since commit
>> 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
>>
>>   Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.12
>>
>> for you to fetch changes up to b522877b53cf3f26d7f072616a45e10fe579cd19:
>>
>>   arm: zynq: hotplug: Remove unreachable code (2013-08-20 07:32:13 +0200)
>>
>> ----------------------------------------------------------------
>> arm: Xilinx Zynq cleanup patches for v3.12
>>
>> This branch contains these fixes:
>> - SLCR cleanup
>> - Hotplug cleanup
>>
>> ----------------------------------------------------------------
>> Soren Brinkmann (4):
>>       arm: zynq: slcr: Remove redundant header #includes
>>       arm: zynq: slcr: Clean up #defines
>>       arm: zynq: slcr: Use read-modify-write for register writes
>>       arm: zynq: hotplug: Remove unreachable code
>>
>>  arch/arm/mach-zynq/hotplug.c | 55
>> +++++--------------------------------------------------
>>  arch/arm/mach-zynq/slcr.c    | 45
>> +++++++++++++++++----------------------------
>>  2 files changed, 22 insertions(+), 78 deletions(-)
>>
>> --
>> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
>> w: www.monstr.eu p: +42-0-721842854
>> Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
>> Maintainer of Linux kernel - Xilinx Zynq ARM architecture
>> Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
>>
>>
>>
