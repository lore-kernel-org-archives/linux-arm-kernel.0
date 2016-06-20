From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 20 Jun 2016 15:45:26 +0100
Subject: [GIT PULL] ARM: vexpress: fixes for v4.8
Message-ID: <57680186.7040105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC team,

Here are the few changes for fixing build with W=1 option on Vexpress
platforms for v4.8. Not sure whether this should be categorized as
cleanups or fixes. Please pull !

-- 
Regards,
Sudeep

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
tags/vexpress-fixes-4.8

for you to fetch changes up to 0a14d280e17ef3db75254439dfc83f1bc65fca6f:

   power: vexpress: make dev_attr_active static (2016-06-13 09:55:51 +0100)

----------------------------------------------------------------
ARMv7 VExpress fixes for v4.8

Few fixes to remove build warnings with W=1

----------------------------------------------------------------
Ben Dooks (4):
       ARM: vexpress/hotplug: fix missing core.h include
       ARM: versatile: fix missing <plat/platsmp.h> include
       ARM: vexpress/spc: fix missing include of spc.h
       power: vexpress: make dev_attr_active static

Sudeep Holla (1):
       ARM: vexpress/spc: remove unused variable perf_stat_reg

  arch/arm/mach-vexpress/hotplug.c        | 2 ++
  arch/arm/mach-vexpress/spc.c            | 6 +++---
  arch/arm/plat-versatile/platsmp.c       | 2 ++
  drivers/power/reset/vexpress-poweroff.c | 4 ++--
  4 files changed, 9 insertions(+), 5 deletions(-)
