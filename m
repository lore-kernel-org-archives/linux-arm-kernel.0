From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 22 Jan 2017 22:47:14 +0900
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates (64bit) for v4.11
Message-ID: <CAK7LNAQNW8P-gJzjvpU-C8=8OvbzHSwWTnGJ59-UNhxfoCC+NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (64bit) updates for the v4.11 merge window.
Please pull!

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.11

for you to fetch changes up to 3a93cc261a29bde973a5ac9a9800c12ce362f5a1:

  arm64: dts: uniphier: add eMMC controller node for LD11/LD20
(2017-01-22 21:12:42 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.11

- Add an SD reset controller node for LD11 SoC
- Add an eMMC controller node for LD11/LD20 SoC

----------------------------------------------------------------
Masahiro Yamada (2):
      arm64: dts: uniphier: add SD-ctrl node for LD11 SoC
      arm64: dts: uniphier: add eMMC controller node for LD11/LD20

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 21 +++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 10 ++++++++++
 2 files changed, 31 insertions(+)

-- 
Best Regards
Masahiro Yamada
