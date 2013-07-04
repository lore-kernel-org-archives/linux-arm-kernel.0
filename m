From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 04 Jul 2013 13:06:38 +0100
Subject: [PULL] Enable KVM on arm64, take #2
Message-ID: <51D5654E.5010908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paolo, Gleb,

Following Linus' pull of the KVM/arm64 code, please pull the following
patch that actually enables KVM on AArch64 platforms.

The patch has also been posted as a separate email:
https://lists.cs.columbia.edu/pipermail/kvmarm/2013-July/006246.html

Thanks,

	M.

The following changes since commit fe489bf4505ae26d3c6d6a1f1d3064c2a9c5cd85:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2013-07-03 13:21:40 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/enable-kvm-for-3.11

for you to fetch changes up to 980ed6a84cb708ba5f14f01d7df4b2e311a4bdcb:

  arm64: KVM: Kconfig integration (2013-07-04 12:58:27 +0100)

----------------------------------------------------------------
Marc Zyngier (1):
      arm64: KVM: Kconfig integration

 arch/arm64/Kconfig              |  2 ++
 arch/arm64/kernel/asm-offsets.c |  1 +
 arch/arm64/kvm/Kconfig          | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 arch/arm64/kvm/Kconfig

-- 
Jazz is not dead. It just smells funny...
