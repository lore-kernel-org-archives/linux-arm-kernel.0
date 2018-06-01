From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 1 Jun 2018 22:17:39 +0200 (CEST)
Subject: linux-next-20180601: build error in arch/arm64/kvm/hyp/hyp-entry.S
Message-ID: <1811039297.78233.1527884259244@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

i can't build todays linux-next-20180601 and get the following error message:

arch/arm64/kvm/hyp/hyp-entry.S: Assembler messages:
arch/arm64/kvm/hyp/hyp-entry.S:128: Error: constant expression required at operand 3 -- `bfi x0,x1,#VCPU_WORKAROUND_2_FLAG_SHIFT,#1'

Related commit:
arm64: KVM: Handle guest's ARCH_WORKAROUND_2 requests

Toolchain: gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu
Kernel config: arm64/defconfig

Regards
Stefan
