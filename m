From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 19 Jul 2018 08:01:06 +0900
Subject: [GIT PULL 1/3] ARM: dts: uniphier: UniPhier DT updates for v4.19
Message-ID: <CAK7LNASA08wMtQaEfZy66u-EubV7X-u+z6KcTrtq_yXzWyzPvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull UniPhier DT (32bit) updates for the v4.19 MW.

Thanks!



The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.19

for you to fetch changes up to 38dc27c85e642cd6229f3a4b2c85128501852158:

  ARM: dts: uniphier: Add missing cooling device properties for CPUs
(2018-07-19 06:42:16 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.19

- Add missing #cooling-cells properties

----------------------------------------------------------------
Viresh Kumar (1):
      ARM: dts: uniphier: Add missing cooling device properties for CPUs

 arch/arm/boot/dts/uniphier-pxs2.dtsi | 3 +++
 1 file changed, 3 insertions(+)


-- 
Best Regards
Masahiro Yamada
