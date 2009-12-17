From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 17 Dec 2009 16:51:33 +0800
Subject: [GIT PULL] pxa: minor fixes for building issues
Message-ID: <f17812d70912170051l7153dfefhc7265b90cac1ce01@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Actually two fixes in this pull request, resolving two building issues, so would
like this to go in soon.

The following changes since commit 3ea6b3d0e6d0ffd91c0f8cadeb69b7133c038b32:
  Linus Torvalds (1):
        Merge branch 'for_linus' of git://git.kernel.org/.../jack/linux-udf-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Eric Miao (2):
      revert "[ARM] pxa/cm-x300: add PWM backlight support"
      [ARM] pxa: fix no reference of cpu_is_pxa25x() in devices.c

Igor Grinberg (1):
      [ARM] pxa/cm-x300: add PWM backlight support

 arch/arm/mach-pxa/Kconfig   |    3 ++-
 arch/arm/mach-pxa/devices.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
