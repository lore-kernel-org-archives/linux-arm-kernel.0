From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 29 Dec 2017 21:30:47 +0900
Subject: [GIT PULL] ARM: uniphier: fixes for v4.15 (2nd)
Message-ID: <CAK7LNAQodyYzeD9kujN05EQQzfZPwWOq1AmBCvKd2FDnnRF7AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the 2nd bug-fix pull request for v4.15.
Just one DT fix.  Please pull!



The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
uniphier-fixes-v4.15-2

for you to fetch changes up to 2e76d9e2b64f71d6b46db6cc12104750cf84c0e7:

  arm64: dts: uniphier: fix gpio-ranges property of PXs3 SoC
(2017-12-29 21:21:54 +0900)

----------------------------------------------------------------
UniPhier ARM SoC fixes for v4.15 (2nd)

- fix gpio-ranges of PXs3 SoC

----------------------------------------------------------------
Masahiro Yamada (1):
      arm64: dts: uniphier: fix gpio-ranges property of PXs3 SoC

 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)



-- 
Best Regards
Masahiro Yamada
