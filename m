From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Mar 2017 21:51:45 +0200
Subject: [GIT PULL] Gemini DTS updates for v4.12
Message-ID: <CACRpkdYGaRwE557fLVx9nCDL1vDvsK18pRUOqHwf184kL=9Acg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are some device tree updates for the Gemini on top of
the initial device tree submission.

These go into the branch "gemini/dts" in your tree.

Details in the signed tag.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit 6ae4d211ab066ad3b808a2b7f0851837c44f495d:

  ARM: dts: add watchdog to the Gemini (2017-03-12 12:18:29 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemini-dts-2

for you to fetch changes up to e3aeca1d74366a43d28e8c826ac48064f7287022:

  ARM: dts: add PCI to the Gemini device trees (2017-03-24 19:08:03 +0100)

----------------------------------------------------------------
DTS updates for the Gemini on top of the multiplatform base:

- Add the power controller to the DTS.
- Augment the GPIO nodes to also include the Faraday
  compatible.
- Add the PCI bus host and config to the Gemini device trees.

----------------------------------------------------------------
Linus Walleij (3):
      ARM: dts: add power controller to the Gemini DTS
      ARM: dts: augment Gemini GPIO nodes
      ARM: dts: add PCI to the Gemini device trees

 arch/arm/boot/dts/gemini-sq201.dts | 22 ++++++++++++++++
 arch/arm/boot/dts/gemini.dtsi      | 54 +++++++++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 3 deletions(-)
