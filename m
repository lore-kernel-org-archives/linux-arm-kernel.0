From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Dec 2013 01:18:44 +0100
Subject: [GIT PULL] Nomadik DT changes for v3.14
Message-ID: <CACRpkdawdmun_jc14-40feTK485J-_dgm6k_oVd60JJXzfSfuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

please pull these two Nomadik patches into the ARM SoC tree
for some boiling in linux-next. Patches are device tree related.

Yours,
Linus Walleij


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-dt-v3.14

for you to fetch changes up to 6568eccd10f6d417f7e40160ca29c965a34b6254:

  ARM: nomadik: get rid of explicit ethernet GPIO management
(2013-11-28 21:08:42 +0100)

----------------------------------------------------------------
Some Nomadik Device Tree updates for the v3.14 cycle:

- Drop 0x prefixes

- Get rid of explicit GPIO management

----------------------------------------------------------------
Lee Jones (1):
      ARM: nomadik: Remove '0x's from nomadik stn8815 DTS file

Linus Walleij (1):
      ARM: nomadik: get rid of explicit ethernet GPIO management

 arch/arm/boot/dts/ste-nomadik-s8815.dts    |  4 ----
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi |  4 ++--
 arch/arm/mach-nomadik/cpu-8815.c           | 32 ------------------------------
 3 files changed, 2 insertions(+), 38 deletions(-)
