From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Jan 2013 18:00:49 +0000
Subject: [GIT PULL] hyp-boot updates for 3.9
Message-ID: <20130123180048.GF26811@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Here is the other half of my hyp-boot collection (you took the first
half as fixes for 3.8), targetted for 3.9.

Cheers,

Will

--->8

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/virt/hyp-boot/updates

for you to fetch changes up to 651134b01240aad44a0eed141e946d835aa93579:

  ARM: virt: hide CONFIG_ARM_VIRT_EXT from user (2013-01-10 21:09:33 +0000)

----------------------------------------------------------------
Russell King (1):
      ARM: virt: avoid clobbering lr when forcing svc mode

Will Deacon (2):
      ARM: virt: use PSR_N_BIT for detecting boot CPU mode mismatch
      ARM: virt: hide CONFIG_ARM_VIRT_EXT from user

 arch/arm/include/asm/assembler.h | 10 +++-------
 arch/arm/include/asm/virt.h      |  4 ++--
 arch/arm/mm/Kconfig              | 10 +++-------
 3 files changed, 8 insertions(+), 16 deletions(-)
