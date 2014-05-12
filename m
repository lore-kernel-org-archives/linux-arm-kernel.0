From: tixy@linaro.org (Jon Medhurst)
Date: Mon, 12 May 2014 12:31:31 +0100
Subject: [PATCH RESEND 0/3] Fixes for kprobes test issues
Message-ID: <1399894294-4144-1-git-send-email-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a repost of my earlier kprobes fixes [1] updated for Linux 3.15.

Russell, if you're OK with these, do you want them in the patch tracker?
Or you can use the pull request below... Thanks.

The following changes since commit d6d211db37e75de2ddc3a4f979038c40df7cc79c:

  Linux 3.15-rc5 (2014-05-09 13:10:52 -0700)

are available in the git repository at:

  git://git.linaro.org/people/tixy/kernel.git kprobes-test-fixes

for you to fetch changes up to e5dfbe7b1cfe2c41111abfead8ecbefb46c0aba3:

  ARM: kprobes: Fix test code compilation errors for ARMv4 targets (2014-05-12 09:59:37 +0100)

----------------------------------------------------------------
Jon Medhurst (3):
      ARM: kprobes: Prevent known test failures stopping other tests running
      ARM: kprobes: Disallow instructions with PC and register specified shift
      ARM: kprobes: Fix test code compilation errors for ARMv4 targets

 arch/arm/kernel/kprobes-test-arm.c |   30 ++++++++++++++++++++----------
 arch/arm/kernel/kprobes-test.c     |   10 ++++++++++
 arch/arm/kernel/probes-arm.c       |    6 +++---
 3 files changed, 33 insertions(+), 13 deletions(-)


[1] http://www.spinics.net/lists/arm-kernel/msg314527.html
