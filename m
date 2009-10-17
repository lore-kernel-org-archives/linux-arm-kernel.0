From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 17 Oct 2009 23:18:36 +0800
Subject: [GIT PULL] pxa: 2 fixes for 2.6.32-rc5
Message-ID: <f17812d70910170818h6efd25bfmf3d07e0c84b0b664@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please consider pull:

The following changes since commit 012abeea669ea49636cf952d13298bb68654146a:
  Linus Torvalds (1):
        Linux 2.6.32-rc5

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Mike Rapoport (1):
      [ARM] pxa/cm-x300: fix mmc numbering

Stanislav Brabec (1):
      [ARM] pxa/spitz: add gpio button support (fixes regression)

 arch/arm/mach-pxa/cm-x300.c |   38 +++++++++++++++++++-------------------
 arch/arm/mach-pxa/spitz.c   |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 19 deletions(-)
