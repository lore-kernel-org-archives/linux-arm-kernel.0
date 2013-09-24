From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 24 Sep 2013 12:49:19 -0700
Subject: [GIT PULL] KVM/ARM Fixes for 3.12-rc2
Message-ID: <1380052160-20755-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 62d228b8c676232eca579f91cc0782b060a59097:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2013-09-17 22:20:30 -0400)

are available in the git repository at:


  git://git.linaro.org/people/cdall/linux-kvm-arm.git tags/kvm-arm-fixes-3.12-rc2

for you to fetch changes up to ac570e0493815e0b41681c89cb50d66421429d27:

  ARM: kvm: rename cpu_reset to avoid name clash (2013-09-24 11:15:05 -0700)

----------------------------------------------------------------
KVM/ARM Fixes for 3.12-rc2

Fixes compilation error with KVM/ARM enabled.

----------------------------------------------------------------
Olof Johansson (1):
      ARM: kvm: rename cpu_reset to avoid name clash

 arch/arm/kvm/reset.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.10.4
