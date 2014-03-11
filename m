From: tixy@linaro.org (Jon Medhurst)
Date: Tue, 11 Mar 2014 16:54:51 +0000
Subject: [PATCH 0/3] Fixes for kprobes test issues
Message-ID: <1394556894-18592-1-git-send-email-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series fixes issues found with the kprobes tests during
testing of Dave Long's latest ARM uprobe patches [1]. Whilst these fixes
are based on top of that series all the bugs are already present in the
kernel tree.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/238862.html

Contents:

Jon Medhurst (3):
      ARM: kprobes: Prevent known test failures stopping other tests running
      ARM: kprobes: Disallow instructions with PC and register specified shift
      ARM: kprobes: Fix test code compilation errors for ARMv4 targets

 arch/arm/kernel/kprobes-test-arm.c |   33 +++++++++++++++++++++------------
 arch/arm/kernel/kprobes-test.c     |   10 ++++++++++
 arch/arm/kernel/probes-arm.c       |    6 +++---
