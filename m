From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 25 May 2017 14:04:03 +0200
Subject: [GIT PULL] ARM: realtek: arm64 for v4.12
Message-ID: <20170525120404.32034-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

This is the initial arm64 pull for Realtek.

Regards,
Andreas

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://github.com/afaerber/linux.git tags/realtek-arm64-soc-for-4.12

for you to fetch changes up to de9aa5308247160950a3ab6420de79014a040699:

  MAINTAINERS: Add Realtek section (2017-05-25 12:24:12 +0200)

----------------------------------------------------------------
Realtek ARM64 SoC for v4.12

This adds a Kconfig symbol for DTs being added, plus a MAINTAINERS entry.

----------------------------------------------------------------
Andreas F?rber (2):
      ARM64: Prepare Realtek RTD1295
      MAINTAINERS: Add Realtek section

 MAINTAINERS                  | 7 +++++++
 arch/arm64/Kconfig.platforms | 6 ++++++
 2 files changed, 13 insertions(+)
