From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Sep 2011 14:23:35 +0200
Subject: [GIT PULL] ux500-fixes for v3.1
Message-ID: <CACRpkdZhsHd=Cm1jQyU_u6yRO4ZOsnXTxLdvOH1AC5dxdXTTWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

As requested, here is a git branch with the ux500 fixes
elegible for v3.1. The only changes to the patches already
floated on the mailing list is the addition of the ARM:
prefix at nicos request, and rebased to v3.1-rc7.

As noted they have also been resubmitted with
Cc: stable at kernel.org.

The following changes since commit d93dc5c4478c1fd5de85a3e8aece9aad7bbae044:

  Linux 3.1-rc7 (2011-09-21 16:58:15 -0700)

are available in the git repository at:
  git://git.linaro.org/people/triad/linux-stericsson.git fixes-for-arnd

Linus Walleij (1):
      ARM: mach-ux500: unlock I&D l2x0 caches before init

srinidhi kasagar (1):
      ARM: mach-ux500: enable fix for ARM errata 754322

 arch/arm/mach-ux500/Kconfig |    1 +
 arch/arm/mach-ux500/cpu.c   |   25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletions(-)

Yours,
Linus Walleij
