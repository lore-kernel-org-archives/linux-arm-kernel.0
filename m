From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 04 Jul 2013 11:45:25 +0100
Subject: [PULL] Enable KVM on arm64
Message-ID: <51D55245.8080207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paolo, Gleb,

Following Linus' pull of the KVM/arm64 code, please pull the following
patch that actually enables KVM on AArch64 platforms.

Thanks,

	M.

The following changes since commit ddcf6600b133697adbafd96e080818bdc0dfd028:

  Merge tag 'hwmon-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging (2013-07-03 19:56:35 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/enable-kvm-for-3.11

for you to fetch changes up to e48bf1151165524a42a63611edcc961249ecc4b4:

  arm64: KVM: Kconfig integration (2013-07-04 11:34:43 +0100)

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
