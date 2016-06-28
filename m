From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 28 Jun 2016 18:43:48 +0100
Subject: [GIT PULL] ARM: hisi: soc changes for v4.8
Message-ID: <5772B754.2080701@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-armv7-soc-for-4.8

for you to fetch changes up to c90047616d4411ff6e7a8a40ed87731dda0753b9:

  ARM: hisi: add compatible string for Hi3519 soc (2016-06-28 16:24:33 +0100)

----------------------------------------------------------------
ARM: mach-hisi: Hisilicon SoC updates for 4.8

- Add initial support for the hi3519 SoC based on armv7
- Avoid the compiling warning by making unexported symbols static

----------------------------------------------------------------
Ben Dooks (1):
      ARM: hisi: make unexported symbols static

Jiancheng Xue (1):
      ARM: hisi: add compatible string for Hi3519 soc

 arch/arm/mach-hisi/hisilicon.c | 23 ++++-------------------
 arch/arm/mach-hisi/platsmp.c   |  4 ++--
 2 files changed, 6 insertions(+), 21 deletions(-)
