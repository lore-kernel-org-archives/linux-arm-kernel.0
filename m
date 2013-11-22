From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 22 Nov 2013 15:57:16 -0800
Subject: [PATCH 0/3] arm/arm64: KVM: vgic: Various bugfixes and improvements
Message-ID: <1385164639-18710-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series contains two initial bugfixes and a performance
optimization that reduces world-switch cost slightly in the vgic
handling code.

Applies to kvm-arm-next.

Christoffer Dall (3):
  arm/arm64: KVM: vgic: Bugfix in handle_mmio_cfg_reg
  arm/arm64: KVM: vgic: Bugfix in vgic_dispatch_sgi
  arm/arm64: KVM: vgic: Use non-atomic bitops

 virt/kvm/arm/vgic.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

-- 
1.8.4.3
