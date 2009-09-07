From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 8 Sep 2009 00:09:58 +0800
Subject: [GIT PULL] pxa: 1 fix for zaurus resume
Message-ID: <f17812d70909070909q556e6cbcu84d9dc14ccb8691b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

This is a bit late, please consider this fix for zaurus resume in .31.

The following changes since commit 422bef879e84104fee6dc68ded0e371dbeb5f88e:
  Linus Torvalds (1):
        Linux 2.6.31-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Pavel Machek (1):
      [ARM] pxa/sharpsl_pm: zaurus c3000 aka spitz: fix resume

 arch/arm/mach-pxa/sharpsl_pm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
