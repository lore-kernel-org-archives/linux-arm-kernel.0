From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 5 Aug 2017 23:56:33 +0200
Subject: [GIT PULL] Gemini changes for v4.14
Message-ID: <CACRpkdZ6D=VdS6wHjF3AuNkvp7xty8t+OAQgwAAyW7ko_4mjrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

please pull these (simple) changes into the ARM SoC tree
for v4.14. Details in the signed tag.

Yours,
Linus Walleij

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemini-for-arm-soc-1

for you to fetch changes up to 2cdbd763f21378c49feca334b4e0d119c799a0ff:

  ARM: gemini: select pin controller (2017-08-05 23:48:29 +0200)

----------------------------------------------------------------
These are some Gemini updates for v4.14.
They all deal with fixing up the Kconfig selects
for misc stuff that has been merged in different
subsystems:

- We have a reset controller
- We have a clock controller
- We need ARM_AMBA for FTDMAC020 which is PL08x
- We need to select the pin controller (being merged
  for v4.14)

----------------------------------------------------------------
Linus Walleij (4):
      ARM: gemini: tag the arch as having reset controller
      ARM: gemini: select the clock controller
      ARM: gemini: select ARM_AMBA
      ARM: gemini: select pin controller

 arch/arm/mach-gemini/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)
