From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Sep 2014 11:02:50 +0200
Subject: [GIT PULL] single Integrator patch for v3.18
Message-ID: <CACRpkdaDH2pjD9q4U7n=E6irdGyN_xVjwBjOfxNO0MfWWK-tUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a single IM-PD1 Integrator related patch for v3.18.
Please pull it in as a separate new feature.

Yours,
Linus Walleij

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-for-v3.18-1

for you to fetch changes up to 684284b64aae96c8d5de0dc0d6e4b72f8b3502ce:

  ARM: integrator: add MMCI device to IM-PD1 (2014-08-19 12:14:48 -0500)

----------------------------------------------------------------
This sets up the dynamically detected IM-PD1 GPIO lines
by way of GPIO descriptors, avoiding any use of the GPIO
global numberspace.

----------------------------------------------------------------
Linus Walleij (1):
      ARM: integrator: add MMCI device to IM-PD1

 arch/arm/mach-integrator/impd1.c | 48 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
