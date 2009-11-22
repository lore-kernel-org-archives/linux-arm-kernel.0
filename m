From: eric.miao@canonical.com (Eric Miao)
Date: Sun, 22 Nov 2009 09:36:31 -0600
Subject: [GIT PULL] pxa: fix for v2.6.32-rc8
Message-ID: <f17812d70911220736i3f5dd4d4x96f5339a006f1a29@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

he following changes since commit 648f4e3e50c4793d9dbf9a09afa193631f76fa26:
  Linus Torvalds (1):
        Linux 2.6.32-rc8

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Daniel Mack (1):
      [ARM] pxa/cpufreq: fix index assignments for end marker

Pavel Machek (1):
      [ARM] pxa/spitz: fix compile regression on spitz

 arch/arm/mach-pxa/cpufreq-pxa2xx.c |    1 +
 arch/arm/mach-pxa/cpufreq-pxa3xx.c |    2 +-
 arch/arm/mach-pxa/spitz.c          |    2 ++
 3 files changed, 4 insertions(+), 1 deletions(-)

- eric
