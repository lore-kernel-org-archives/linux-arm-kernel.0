From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 30 Aug 2013 15:59:53 -0700
Subject: [GIT PULL] KVM/ARM Updates for 3.12
Message-ID: <1377903597-18704-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gleb and Paolo,

The following changes since commit cc2df20c7c4ce594c3e17e9cc260c330646012c8:

  KVM: x86: Update symbolic exit codes (2013-08-13 16:58:42 +0200)

are available in the git repository at:

  git://git.linaro.org/people/cdall/linux-kvm-arm.git tags/kvm-arm-for-3.12

for you to fetch changes up to 1fe40f6d39d23f39e643607a3e1883bfc74f1244:

  ARM: KVM: Add newlines to panic strings (2013-08-30 15:48:02 -0700)

----------------------------------------------------------------
KVM/ARM Updates for Linux 3.12

----------------------------------------------------------------
Christoffer Dall (4):
      ARM: KVM: Fix kvm_set_pte assignment
      ARM: KVM: Simplify tracepoint text
      ARM: KVM: Work around older compiler bug
      ARM: KVM: Add newlines to panic strings

 arch/arm/include/asm/kvm_mmu.h |    2 +-
 arch/arm/kvm/interrupts.S      |    8 ++++----
 arch/arm/kvm/reset.c           |    2 +-
 arch/arm/kvm/trace.h           |    7 +++----
 4 files changed, 9 insertions(+), 10 deletions(-)
