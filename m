From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 May 2013 18:39:26 -0700
Subject: [GIT PULL] KVM/ARM Fixes for 3.10
Message-ID: <CAMJs5B8qTMpaaq0y=xGUrTzUd_-LvmARdGABV8PdpqmWUkPoqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e47a5f5fb715b90b40747e9e235de557c6abd56c:

  KVM: x86 emulator: convert XADD to fastop (2013-05-21 15:43:24 +0300)

are available in the git repository at:

  git://github.com/columbia/linux-kvm-arm.git kvm-arm-fixes-3.10

for you to fetch changes up to f3afcd8bf501e98e7707865930338e5a82d8ed88:

  ARM: KVM: be more thorough when invalidating TLBs (2013-05-27 19:34:20 -0700)

----------------------------------------------------------------
Andre Przywara (1):
      ARM: KVM: prevent NULL pointer dereferences with KVM VCPU ioctl

Marc Zyngier (1):
      ARM: KVM: be more thorough when invalidating TLBs

 arch/arm/kvm/arm.c |   15 +++++++++++++--
 arch/arm/kvm/mmu.c |   41 ++++++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 17 deletions(-)
