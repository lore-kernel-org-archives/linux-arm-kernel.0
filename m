From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 02 Jul 2014 13:06:26 +0100
Subject: [GIT PULL] Fixes for kprobes test issues
Message-ID: <1404302786.3470.23.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

Please can you pull these kprobes test changes which fix the known
issues with compiling and running on various different platforms?
Thanks.

The following changes since commit a497c3ba1d97fc69c1e78e7b96435ba8c2cb42ee:

  Linux 3.16-rc2 (2014-06-21 19:02:54 -1000)

are available in the git repository at:

  git://git.linaro.org/people/tixy/kernel.git kprobes-test-fixes

for you to fetch changes up to 449fd15fbcde239875031d70fd06abb4a0e1ed09:

  ARM: kprobes: Fix test code compilation errors for ARMv4 targets (2014-07-02 12:48:36 +0100)

----------------------------------------------------------------
Jon Medhurst (3):
      ARM: kprobes: Prevent known test failures stopping other tests running
      ARM: kprobes: Disallow instructions with PC and register specified shift
      ARM: kprobes: Fix test code compilation errors for ARMv4 targets

 arch/arm/kernel/kprobes-test-arm.c |   30 ++++++++++++++++++++----------
 arch/arm/kernel/kprobes-test.c     |   10 ++++++++++
 arch/arm/kernel/probes-arm.c       |    6 +++---
 3 files changed, 33 insertions(+), 13 deletions(-)
