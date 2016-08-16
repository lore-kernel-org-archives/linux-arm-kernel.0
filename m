From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 16 Aug 2016 17:10:32 +0200
Subject: [PATCH 0/2] Rework vgic_attr_regs_access
Message-ID: <20160816151034.16930-1-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two small patches to split up the functionality in vgic_attr_regs_access to
make life simpler when having to deal with GICv3 save/restore.

Christoffer Dall (2):
  KVM: arm/arm64: Factor out vgic_attr_regs_access functionality
  KVM: arm/arm64: Rename vgic_attr_regs_access to
    vgic_attr_regs_access_v2

 virt/kvm/arm/vgic/vgic-kvm-device.c | 125 +++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 38 deletions(-)

-- 
2.9.0
