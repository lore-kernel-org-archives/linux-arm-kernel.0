From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Oct 2018 13:26:10 +0100
Subject: [GIT PULL 0/1] KVM/arm updates for 4.19-rc8
Message-ID: <20181009122611.85534-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paolo, Radim,

This is hopefully the last 4.19 update for KVM/arm. A single patch,
but one that fixes a rather silly 32bit bug (which I thought I had
fixed before sending the original 4.19 PR, but obviously didn't).

Please pull,

	M.

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvmarm-fixes-for-4.19-2

for you to fetch changes up to ec876f4b252c4084acad259ce3e65ad97f44f040:

  ARM: KVM: Correctly order SGI register entries in the cp15 array (2018-10-09 11:55:47 +0100)

----------------------------------------------------------------
KVM/arm fixes for 4.19, take #2

- Correctly order GICv3 SGI registers in the cp15 array

----------------------------------------------------------------
Marc Zyngier (1):
      ARM: KVM: Correctly order SGI register entries in the cp15 array

 arch/arm/kvm/coproc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
