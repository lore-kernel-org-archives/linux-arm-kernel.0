From: drjones@redhat.com (Andrew Jones)
Date: Sat, 14 Sep 2013 14:10:53 +0200
Subject: [PATCH 0/3] KVM_MAX_VCPUS related changes
Message-ID: <1379160656-28050-1-git-send-email-drjones@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Jones (3):
  arm: kvm: clamp NR_VCPUS to MAX_VCPUS
  arm32: kvm: rename CONFIG_KVM_ARM_MAX_VCPUS
  aarch64: kvm: introduce CONFIG_KVM_MAX_VCPUS

 arch/arm/include/asm/kvm_host.h   |  4 ++--
 arch/arm/kvm/Kconfig              |  8 ++++----
 arch/arm/kvm/arm.c                |  2 +-
 arch/arm64/include/asm/kvm_host.h |  7 ++++++-
 arch/arm64/kvm/Kconfig            | 11 +++++++++++
 5 files changed, 24 insertions(+), 8 deletions(-)

-- 
1.8.1.4
