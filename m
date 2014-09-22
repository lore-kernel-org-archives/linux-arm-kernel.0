From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 22 Sep 2014 23:12:29 +0200
Subject: [GIT PULL] Last-minute fix for kvm/arm64
Message-ID: <1411420350-368-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo and Gleb,

Can you forward this single fix to Linus before he releases v3.17?

The following changes since commit 05e0127f9e362b36aa35f17b1a3d52bca9322a3a:

  arm/arm64: KVM: Complete WFI/WFE instructions (2014-08-29 11:53:53 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-v3.17-rc7-or-final

for you to fetch changes up to 1f2bb4acc125edc2c06db3ad3e8c699bc075ad52:

  arm/arm64: KVM: Fix unaligned access bug on gicv2 access (2014-09-22 23:05:56 +0200)

Thanks!
-Christoffer

----------------------------------------------------------------
Fixes unaligned access to the gicv2 virtual cpu status.

----------------------------------------------------------------
Christoffer Dall (1):
      arm/arm64: KVM: Fix unaligned access bug on gicv2 access

 virt/kvm/arm/vgic-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
