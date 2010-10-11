From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Oct 2010 15:37:32 +0800
Subject: [GIT PULL] Introduce patching of phys_to_virt and vice versa
Message-ID: <AANLkTikpt0=hzZBO0oZtibGnY5NJm4AFQQ8edMDYevKn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

If you are OK with this patch, please help pull. Or let me know if you
want me to
put this into your tracking system.

The following changes since commit cb655d0f3d57c23db51b981648e452988c0223f9:
  Linus Torvalds (1):
        Linux 2.6.36-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git
phys_to_virt

Eric Miao (1):
      ARM: Introduce patching of phys_to_virt and vice versa

 arch/arm/Kconfig              |   10 ++++++++
 arch/arm/include/asm/memory.h |   32 ++++++++++++++++++++++++++
 arch/arm/kernel/setup.c       |   50 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/vmlinux.lds.S |    4 +++
 4 files changed, 96 insertions(+), 0 deletions(-)
