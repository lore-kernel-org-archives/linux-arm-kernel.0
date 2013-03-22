From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Mar 2013 17:43:38 +0000
Subject: [PULL] VGIC fixes for KVM/ARM
Message-ID: <514C984A.4020800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please find below a pull request for a couple of important VGIC fixes
for KVM on ARM. If you could merge them as part of your next batch of
fixes for the upcoming -rc, it would be much appreciated.

Thanks,

	M.

The following changes since commit 2ef14f465b9e096531343f5b734cffc5f759f4a6:

  Merge branch 'x86-mm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2013-02-21 18:06:55 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/vgic-fixes

for you to fetch changes up to 33c83cb3c1d84b76c8270abe5487e77f83a81b22:

  ARM: KVM: vgic: take distributor lock on sync_hwstate path (2013-02-22 13:29:38 +0000)

----------------------------------------------------------------
Marc Zyngier (2):
      ARM: KVM: vgic: force EOIed LRs to the empty state
      ARM: KVM: vgic: take distributor lock on sync_hwstate path

 arch/arm/kvm/vgic.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

-- 
Jazz is not dead. It just smells funny...
