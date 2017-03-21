From: tixy@linaro.org (Jon Medhurst)
Date: Tue, 21 Mar 2017 17:11:58 +0000
Subject: [GIT PULL] arm: kprobe fixes
Message-ID: <1490116318.3136.7.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell

Please consider pulling these arm kprobe fixes. I thought I'd send these
now rather than waiting for resolution of the other issues I found as
those aren't to do with kprobe specific code (and I thought they can go
into the patch tracker later). Thanks.

The following changes since commit 4495c08e84729385774601b5146d51d9e5849f81:

  Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)

are available in the git repository at:

  https://git.linaro.org/people/tixy/kernel.git kprobe-fixes

for you to fetch changes up to 974310d047f3c7788a51d10c8d255eebdb1fa857:

  arm: kprobes: Align stack to 8-bytes in test code (2017-03-21 16:24:19 +0000)

----------------------------------------------------------------
Jon Medhurst (1):
      arm: kprobes: Align stack to 8-bytes in test code

Masami Hiramatsu (3):
      arm: kprobes: Allow to handle reentered kprobe on single-stepping
      arm: kprobes: Skip single-stepping in recursing path if possible
      arm: kprobes: Fix the return address of multiple kretprobes

 arch/arm/probes/kprobes/core.c      | 49 ++++++++++++++++++++++++++++---------
 arch/arm/probes/kprobes/test-core.c | 11 ++++++---
 2 files changed, 46 insertions(+), 14 deletions(-)
