From: maz@misterjones.org (Marc Zyngier)
Date: Fri, 22 Feb 2013 14:58:12 +0100
Subject: [PULL] VGIC fixes for KVM/ARM
Message-ID: <b06d478e1008aa14c12fa1ea9f8da941@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please find below a pull request for a couple of fixes concerning
the VGIC implementation in KVM. No real hurry, these can probably
be applied after the merge window.

The branch is on top of mainline as of this morning, but I'm happy
to rebase it on something else if that's more convenient.

Thanks,

        M.

---------------->8--------------
The following changes since commit
2ef14f465b9e096531343f5b734cffc5f759f4a6:

  Merge branch 'x86-mm-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2013-02-21 18:06:55
-0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
kvm-arm/vgic-fixes

for you to fetch changes up to 33c83cb3c1d84b76c8270abe5487e77f83a81b22:

  ARM: KVM: vgic: take distributor lock on sync_hwstate path (2013-02-22
13:29:38 +0000)

----------------------------------------------------------------
Marc Zyngier (2):
      ARM: KVM: vgic: force EOIed LRs to the empty state
      ARM: KVM: vgic: take distributor lock on sync_hwstate path

 arch/arm/kvm/vgic.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)


-- 
Who you jivin' with that Cosmik Debris?
