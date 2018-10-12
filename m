From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Sat, 13 Oct 2018 00:12:47 +0800
Subject: [PATCH v4 0/2] rename function name and enable 32bit vcpu events
Message-ID: <20181012161249.9236-1-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the kvm_arch_dev_ioctl_check_extension() to 
kvm_arch_vm_ioctl_check_extension, because the name
is not readable;

Enable the 32 bit vcpu events support.

Change since v3:
1. Address James's comments to update the patch commit messages

Change since v2:
1. Address Suzuki's comments to update the patch commit messages

change since v1:
1. Update patch commit messages.

Dongjiu Geng (2):
  arm/arm64: KVM: rename function kvm_arch_dev_ioctl_check_extension()
  arm/arm64: KVM: enable 32 bits kvm vcpu events support

 arch/arm/include/asm/kvm_host.h   | 2 +-
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kvm/reset.c            | 5 ++---
 virt/kvm/arm/arm.c                | 3 ++-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1
