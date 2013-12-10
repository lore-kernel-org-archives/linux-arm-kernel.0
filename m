From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Dec 2013 11:22:45 +0100
Subject: [GIT PULL] two Integrator devicetree patches
Message-ID: <CACRpkdZcrEtHC+Q0YHOuL8yXQrMixL=n2Nagbk6NBAmdmnnXHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are two patches targeted for v3.14 that I'd like includes
in ARM SoC for testing in -next.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:

  Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-v3.14-1

for you to fetch changes up to 307b96677c98bc444262e3d1a7d26c0ca8a1c6e0:

  ARM: integrator: move EBI to the device tree (2013-12-04 16:22:31 +0100)

----------------------------------------------------------------
Two integrator device tree patches for v3.14:

- Delete some static core module mappings.

- Move EBI location to the device tree.

----------------------------------------------------------------
Linus Walleij (2):
      ARM: integrator: delete static core module mappings
      ARM: integrator: move EBI to the device tree

 Documentation/devicetree/bindings/arm/arm-boards |  8 ++++
 arch/arm/boot/dts/integrator.dtsi                |  5 ++
 arch/arm/mach-integrator/integrator_ap.c         | 60 ++++++++++++------------
 arch/arm/mach-integrator/integrator_cp.c         | 14 ------
 4 files changed, 44 insertions(+), 43 deletions(-)
