From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Apr 2016 22:04:36 +0200
Subject: [GIT PULL] Nomadik DTS changes for v4.7
Message-ID: <CACRpkdbMtUfnSKZHj4D3h+ChKq+V8hqVvNYSShvekAiMLk6tDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are a few Nomadik DTS edits for v4.7:
- Activate the accelerometer on NHK15
- Some DMA support

As it also says in the signed tag.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-dts-v4.7

for you to fetch changes up to a22d7768860aedcd9c4011075c4d3bc1eaaddd63:

  ARM: dts: nomadik: add DMA engine and some channels (2016-04-14
21:47:10 +0200)

----------------------------------------------------------------
Nomadik DTS changes for v4.7:
- Add accelerometer for NHK15
- Add DMA engine definitions and UART channels

----------------------------------------------------------------
Linus Walleij (2):
      ARM: dts: nomadik: add accelerometer IRQ and pin setting
      ARM: dts: nomadik: add DMA engine and some channels

 arch/arm/boot/dts/ste-nomadik-nhk15.dts    | 13 +++++++++-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 38 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)
