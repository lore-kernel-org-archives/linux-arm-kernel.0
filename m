From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Jan 2013 12:17:53 +0000
Subject: [GIT PULL] hyp-boot fixes for 3.8
Message-ID: <20130115121753.GB5649@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

As I mentioned previously, a bunch of fixes to the hyp-boot code have been
accumulating in the branch I originally targeted for 3.9. Given that these
should all go to stable, I've split the fixes out for 3.8 and put them on
their own branch for you to pull (see below).

Cheers,

Will

--->8

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/virt/hyp-boot/fixes

for you to fetch changes up to d01723479e6a6c70c83295f7847477a016d5e14a:

  ARM: virt: simplify __hyp_stub_install epilog (2013-01-10 21:08:55 +0000)

----------------------------------------------------------------
Dave Martin (1):
      ARM: virt: Avoid bx instruction for compatibility with <=ARMv4

Marc Zyngier (2):
      ARM: virt: boot secondary CPUs through the right entry point
      ARM: virt: simplify __hyp_stub_install epilog

 arch/arm/kernel/head.S     |  2 +-
 arch/arm/kernel/hyp-stub.S | 18 ++++++------------
 2 files changed, 7 insertions(+), 13 deletions(-)
