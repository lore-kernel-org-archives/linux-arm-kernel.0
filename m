From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 30 Jun 2016 15:39:35 +0200
Subject: [PULL 0/2] KVM/ARM Fixes for v4.7-rc6
Message-ID: <20160630133937.2654-1-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo and Radim,

Please pull two small fixes for KVM/ARM for rc6 or as soon as it can make it:

They fix a build issue without CONFIG_ARM_PMU and plugs pid leak on arm/arm64.

Thanks,
-Christoffer

The following changes since commit a0052191624e9bf8a8f9dc41b92ab5f252566c3c:

  kvm: vmx: check apicv is active before using VT-d posted interrupt (2016-06-16 09:38:24 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-v4.7-rc6

for you to fetch changes up to 591d215afcc2f94e8e2c69a63c924c044677eb31:

  KVM: arm/arm64: Stop leaking vcpu pid references (2016-06-27 13:08:10 +0200)

James Morse (1):
      KVM: arm/arm64: Stop leaking vcpu pid references

Sudeep Holla (1):
      arm64: KVM: fix build with CONFIG_ARM_PMU disabled

 arch/arm/kvm/arm.c    | 1 +
 include/kvm/arm_pmu.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)
