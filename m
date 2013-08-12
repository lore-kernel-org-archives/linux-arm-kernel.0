From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Aug 2013 21:12:57 -0700
Subject: [GIT PULL] KVM/ARM Fixes for 3.11
Message-ID: <1376280781-6539-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e769ece3b129698d2b09811a6f6d304e4eaa8c29:

  KVM: s390: fix pfmf non-quiescing control handling (2013-07-29 09:02:30 +0200)

are available in the git repository at:

  git://git.linaro.org/people/cdall/linux-kvm-arm.git tags/kvm-arm-fixes-3.11

for you to fetch changes up to 2184a60de26b94bc5a88de3e5a960ef9ff54ba5a:

  KVM: ARM: Squash len warning (2013-08-11 21:03:39 -0700)

----------------------------------------------------------------
Christoffer Dall (3):
      ARM: KVM: Fix 64-bit coprocessor handling
      ARM: KVM: Fix unaligned unmap_range leak
      KVM: ARM: Squash len warning

Marc Zyngier (1):
      arm64: KVM: fix 2-level page tables unmapping

 arch/arm/kvm/coproc.c     |   26 +++++++++++++++++++-------
 arch/arm/kvm/coproc.h     |    3 +++
 arch/arm/kvm/coproc_a15.c |    6 +++++-
 arch/arm/kvm/mmio.c       |    3 ++-
 arch/arm/kvm/mmu.c        |   36 +++++++++++++++---------------------
 5 files changed, 44 insertions(+), 30 deletions(-)
