From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 6 Jul 2016 12:44:53 +0100
Subject: [GIT PULL v2] ARM: hisi: soc changes for v4.8
Message-ID: <577CEF35.8040906@hisilicon.com>
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

  git://github.com/hisilicon/linux-hisi.git tags/hisi-armv7-soc-for-4.8-v2

for you to fetch changes up to e407b3512dc439b66f735385fdb44d7d0db3f727:

  ARM: hisi: add compatible string for Hi3519 soc (2016-07-06 12:05:42 +0100)

----------------------------------------------------------------
ARM: mach-hisi: Hisilicon SoC updates for 4.8

- Add initial support for the hi3519 SoC based on armv7
- Consolidate the hisilicon armv7 SoCs machine entries
- Avoid the compiling warning by making unexported symbols static

----------------------------------------------------------------
Ben Dooks (1):
      ARM: hisi: make unexported symbols static

Jiancheng Xue (1):
      ARM: hisi: add compatible string for Hi3519 soc

 arch/arm/mach-hisi/hisilicon.c | 44 ++++++++++++------------------------------
 arch/arm/mach-hisi/platsmp.c   |  4 ++--
 2 files changed, 14 insertions(+), 34 deletions(-)
