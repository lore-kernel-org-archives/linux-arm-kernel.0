From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 14 Nov 2016 19:37:51 +0100
Subject: [GIT PULL] arm: mediatek: kconfig changes for v4.10
Message-ID: <b9bf2483-533d-ffd1-b23f-d89d20b8a73a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

although late, please pull the following changes.

Thanks,
Matthias
---
The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.9-next-kconfig

for you to fetch changes up to 494975c9cc00f69bf71de0991dcebda9b2911aa0:

   ARM: mediatek: clean up mach-mediatek/Makefile (2016-10-31 15:26:23 
-0600)

----------------------------------------------------------------
- clean up mach-mediatek Makefile as kbuild only descends into the folder if
   ARCH_MEDIATEK is enabled

----------------------------------------------------------------
Masahiro Yamada (1):
       ARM: mediatek: clean up mach-mediatek/Makefile

  arch/arm/mach-mediatek/Makefile | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)
