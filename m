From: monstr@monstr.eu (Michal Simek)
Date: Mon, 21 Jan 2013 19:58:37 +0100
Subject: [GIT PULL] arm-soc: Xilinx zynq timer changes for v3.9
In-Reply-To: <201301211847.28160.arnd@arndb.de>
References: <CAHTX3dJ1JdqH9NKYxOYdOE=5x4fMO2JSNMbcq7dkvPNJkC0VAg@mail.gmail.com>
 <201301211847.28160.arnd@arndb.de>
Message-ID: <CAHTX3dJHgZUZf2H-3h18Jn_pHhLruWGkSAFPPnZOzgF1uhq9NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/21 Arnd Bergmann <arnd@arndb.de>:
> On Monday 21 January 2013, Michal Simek wrote:
>> please pull these timer changes to your arm-soc tree.
>> I am aware about any dependency.
>>
>> Please let me know if you have any problem with this patchset.
>>
>>   git://git.xilinx.com/linux-xlnx.git zynq/timer
>>
>> Soren Brinkmann (7):
>>       arm: zynq: timer: Replace PSS through PS
>>       arm: zynq: timer: Remove unnecessary register write
>>       arm: zynq: timer: Remove unused #defines
>>       arm: zynq: timer: Align columns
>>       arm: zynq: timer: Remove redundant #includes
>>       arm: zynq: timer: Fix comment style
>>       arm: zynq: timer: Set clock_event cpumask
>
> I see nothing wrong with the patches themselves, but there are some
> cleanups in arm-soc for timers that will conflict with them.
>
> Please have a look at the contents of the timer/cleanup and clocksource/cleanup
> branches in arm-soc, and merge them into your branch. If everything still
> works, you can add a patch on top of the merge to move your driver to
> drivers/clocksource and use the new infrastructure introduced there.

ok. Will look at it tmr.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian
