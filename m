From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 18 May 2014 20:07:14 +0800
Subject: [GIT PULL]]ARM: sirf: machine update for 3.16
In-Reply-To: <CAGsJ_4wD=FqxNeuEs47f0D9V+Qhn8jyUQL67iv4rsZ3r2K_3vA@mail.gmail.com>
References: <CAGsJ_4yqTkKu+93Fo_D6NaZMyz4T6_EmKz4gZfyeQCi_uF-3dg@mail.gmail.com>
 <CAGsJ_4wD=FqxNeuEs47f0D9V+Qhn8jyUQL67iv4rsZ3r2K_3vA@mail.gmail.com>
Message-ID: <CAGsJ_4y7gEQd9-Em6LW2kZ79qUOz5dSYzeWnBLbt8o8QsOSA6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Bin Shi (2):
>>       clocksource: prima2: fix some minor checkpatch issues
>>       irqchip: sirf: fix one minor checkpatch issue
>>
>> Xianglong Du (1):
>>       ARM: prima2: rstc: fix some minor checkpatch issues
>>
>> Zhiwu Song (2):
>>       clocksource:sirf: remove the hardcode for the clk of timers
>>       clocksource: marco: fix the affinity set for local timer of CPU1
>
> as Daniel has applied this one "clocksource: marco: fix the affinity
> set for local timer of CPU1" to his clk tree, i'll rebuilt the tag by
> dropping this.

hi Olof,
i did a force update to tags/sirf-soc-for-3.16 after dropping
"clocksource: marco: fix the affinity set for local timer of CPU1"
which has been in clk tree , the new request is as below:

The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:

  Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
tags/sirf-soc-for-3.16

for you to fetch changes up to c7cff54d5926e3f419c23eff2ebaf6f5e12da05d:

  clocksource:sirf: remove the hardcode for the clk of timers
(2014-05-12 21:43:49 +0800)

----------------------------------------------------------------
ARM: sirf: machine update for 3.16

most of them fix some minor checkpatch issues according to key customers'
requirement. And this patchset also cleanups the clk of clocksource: move
to get clk by dts properity.

----------------------------------------------------------------
Bin Shi (2):
      clocksource: prima2: fix some minor checkpatch issues
      irqchip: sirf: fix one minor checkpatch issue

Xianglong Du (1):
      ARM: prima2: rstc: fix some minor checkpatch issues

Zhiwu Song (1):
      clocksource:sirf: remove the hardcode for the clk of timers

 arch/arm/boot/dts/atlas6.dtsi      |    1 +
 arch/arm/boot/dts/prima2.dtsi      |    1 +
 arch/arm/mach-prima2/rstc.c        |   34 +++++++++++++++-----------
 drivers/clocksource/timer-marco.c  |    8 +++---
 drivers/clocksource/timer-prima2.c |   47 ++++++++++++++++++++++--------------
 drivers/irqchip/irq-sirfsoc.c      |    3 ++-
 6 files changed, 56 insertions(+), 38 deletions(-)


-barry
