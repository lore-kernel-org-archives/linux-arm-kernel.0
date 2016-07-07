From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 7 Jul 2016 12:52:36 +0100
Subject: [GIT PULL v3] ARM: hisi: soc changes for v4.8
Message-ID: <577E4284.1060701@hisilicon.com>
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

  git://github.com/hisilicon/linux-hisi.git tags/hisi-armv7-soc-for-4.8-v3

for you to fetch changes up to abee8fbf2b2170efa0956ce1942ebe777a94cfdd:

  ARM: hisi: consolidate the hisilicon machine entries (2016-07-07 09:37:59 +0100)

----------------------------------------------------------------
ARM: mach-hisi: Hisilicon SoC updates for 4.8

- Consolidate the hisilicon armv7 SoCs machine entries
- Avoid the compiling warning by making unexported symbols static

----------------------------------------------------------------
Ben Dooks (1):
      ARM: hisi: make unexported symbols static

Jiancheng Xue (1):
      ARM: hisi: consolidate the hisilicon machine entries

 arch/arm/mach-hisi/hisilicon.c | 28 ----------------------------
 arch/arm/mach-hisi/platsmp.c   |  4 ++--
 2 files changed, 2 insertions(+), 30 deletions(-)
