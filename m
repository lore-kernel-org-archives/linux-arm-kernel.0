From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 5 Jul 2013 12:17:43 +0100
Subject: [GIT PULL] Xen ARM update for 3.11
Message-ID: <alpine.DEB.2.02.1307041229140.5067@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,
just one commit this time: the implementation of the tmem hypercall for
arm and arm64.

NOTE: because this change depends on xen support for arm64 that has been
sent to you by Catalin (we agreed that being the very first xen for arm64
set of patches, it should go via the arm64 maintainers), I based this
branch on Catalin's arm64-upstream (see his pull request here
http://marc.info/?l=linux-arm-kernel&m=137269947606106&w=2).

- Stefano



The following changes since commit aa729dccb5e8dfbc78e2e235b8754d6acccee731:

  Merge branch 'for-next/hugepages' of git://git.linaro.org/people/stevecapper/linux into upstream-hugepages (2013-07-01 11:20:58 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git xenarm-for-3.11-tag

Stefano Stabellini (1):
      xen/arm and xen/arm64: implement HYPERVISOR_tmem_op

 arch/arm/include/asm/xen/hypercall.h |    1 +
 arch/arm/xen/enlighten.c             |    1 +
 arch/arm/xen/hypercall.S             |    1 +
 arch/arm64/xen/hypercall.S           |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)
