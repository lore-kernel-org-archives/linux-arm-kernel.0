From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Jan 2013 16:48:43 +0100
Subject: [GIT PULL v2] arm-soc: Xilinx zynq timer changes for v3.9
In-Reply-To: <CAHTX3d+qeKPT3YYG3=YgWYN5YTS1oT9HoTEpVwC4GZAYve5uYw@mail.gmail.com>
References: <CAHTX3d+qeKPT3YYG3=YgWYN5YTS1oT9HoTEpVwC4GZAYve5uYw@mail.gmail.com>
Message-ID: <CAHTX3dLSp5_OZmuvU18s=A19e7F1Jq7tgTjayV8qFDJ1FTJztA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

can you please look at this pull request?

Thanks,
Michal

2013/1/22 Michal Simek <michal.simek@xilinx.com>:
> Hi Arnd and Olof,
>
> please pull these timer changes to your arm-soc tree.
> As Arnd suggested this branch v2 is based on timer/cleanup and
> clocksource/cleanup arm-soc branches.
> There was one conflict with arch/arm/mach-pxa/time.c which I have resolved
> like Olof in the patch "Merge branch 'clocksource/cleanup' into next/cleanup"
> (sha1: 8d84981e395850aab31c3f2ca7e2738e03f671d7).
> (Also changed indentation in the pxa timer driver as Olof has done)
>
> Arnd also mentioned to move this timer driver to drivers/clocksource
> (+ use the new infrastructure introduced there) but this
> need to be a separate patch which must be reviewed first.
>
> Please let me know if I miss something.
>
> Thanks,
> Michal
>
> The following changes since commit 05ed8a3e5c3a48b5b63305920f88da94d9272b36:
>   Michal Simek (1):
>         Merge branch 'clocksource/cleanup' into zynq/timer
>
> are available in the git repository at:
>
>   git://git.xilinx.com/linux-xlnx.git zynq/timer
>
> Soren Brinkmann (7):
>       arm: zynq: timer: Replace PSS through PS
>       arm: zynq: timer: Remove unnecessary register write
>       arm: zynq: timer: Remove unused #defines
>       arm: zynq: timer: Align columns
>       arm: zynq: timer: Remove redundant #includes
>       arm: zynq: timer: Fix comment style
>       arm: zynq: timer: Set clock_event cpumask
>
>  arch/arm/mach-zynq/common.c |    2 +-
>  arch/arm/mach-zynq/common.h |    2 +-
>  arch/arm/mach-zynq/timer.c  |  150 ++++++++++++++++++++----------------------
>  3 files changed, 73 insertions(+), 81 deletions(-)



-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian
