From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Mar 2017 21:46:31 +0200
Subject: [GIT PULL] Gemini updates for v4.12
Message-ID: <CACRpkda=ai+4hs8GgwxUwyGZjnU1ZPQqARLNFR5t-qqLT4vcVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

these are some Gemini updates on top of the multiplatform
and device tree conversion.

This should go onto the branch named "gemeni/multiplatform"
in the ARM SoC tree, slight misspelling but who cares as long
as it ends up where it is supposed to be.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 6dbb708a8fb8eef552d8de2b7574d92741b3bb31:

  ARM: gemini: convert to ARMv4 multiplatform (2017-03-12 12:27:27 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemini-multiplat-2

for you to fetch changes up to 16c86ef7fc3fff118a985705bf18fe7ec9e493e7:

  ARM: gemini: don't select SERIAL_OF_PLATFORM (2017-03-24 22:12:42 +0100)

----------------------------------------------------------------
Gemini multiplatform updates:

- Select the poweroff driver so the system can properly shut down.
  This driver is merged in the power tree.
- Select the right Faraday GPIO block (we renamed it).
- Do not select SERIAL_OF_PLATFORM that just create Kconfig
  warnings on us. We'll put that into the defconfig instead.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: gemini: don't select SERIAL_OF_PLATFORM

Linus Walleij (2):
      ARM: gemini: select gemini poweroff
      ARM: gemini: select the right GPIO block

 arch/arm/mach-gemini/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
