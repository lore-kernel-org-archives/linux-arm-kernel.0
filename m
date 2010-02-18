From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Thu, 18 Feb 2010 23:11:26 +0200
Subject: [GIT PULL] gemini fix for 2.6.33-rc8
Message-ID: <20100218211126.5646.39087.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull these changes for rc. I am sending patches also for comments
if any.

The following changes since commit 83c5aac175e182c30729650f2edee3294c3b8bb0:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../dtor/input

are available in the git repository at:

  git://gitorious.org/linux-gemini/mainline.git for-rmk

Paulius Zaleckas (1):
      MAINTAINERS: fix my e-mail and status for Gemini and FA526

Roel Kluin (1):
      Gemini: wrong registers used to set reg_level in gpio_set_irq_type()

 MAINTAINERS                 |    8 ++++----
 arch/arm/mach-gemini/gpio.c |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)
