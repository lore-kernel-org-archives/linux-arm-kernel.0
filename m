From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Dec 2017 10:08:22 +0100
Subject: [GIT PULL] Gemini DTS updates for v4.16, take 2
Message-ID: <CACRpkdZB7UFXesbQJHjuM_fdkY7w0USD5suGQevo3efsr+wgOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I realized I forgot two DTS patches and the panel
driver for enabling video on DIR-685 was merged, so here is
a second pull request on top of the Gemini DTS pull request
from yesterday.

Please pull it in on top of the other Gemini DTS patches!

Yours,
Linus Walleij


The following changes since commit dd5c0561db755845f0fd372c9bdb3099dce1a1c8:

  ARM: dts: Add basic devicetree for D-Link DNS-313 (2017-12-16 20:32:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemini-dts-update-2

for you to fetch changes up to ea6f23f59331f11494ef966429a0f8672b5d4109:

  ARM: dts: Add TVE/TVC and ILI9322 panel to DIR-685 (2017-12-22 09:57:05 +0100)

----------------------------------------------------------------
A second set of Gemini DTS updates for v4.16:

- Use Open Drain flags properly for emulated I2C

- Add the PCI bus to WBD111 and WBD222

- Enable the TVE and panel on DIR-685; the panel driver and
  bindings have been merged into the DRI subsystem.

----------------------------------------------------------------
Linus Walleij (3):
      ARM: dts: Flags D-Link DIR-685 I2C bus gpios
      ARM: dts: Add PCI to WBD111 and WBD222
      ARM: dts: Add TVE/TVC and ILI9322 panel to DIR-685

 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 67 ++++++++++++++++++++++++++++--
 arch/arm/boot/dts/gemini-wbd111.dts        | 22 ++++++++++
 arch/arm/boot/dts/gemini-wbd222.dts        | 22 ++++++++++
 3 files changed, 108 insertions(+), 3 deletions(-)
