From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 14 Jun 2010 11:09:49 +0800
Subject: [GIT PULL] pxa: fixes for v2.6.35-rc3
Message-ID: <AANLkTikVogt4MaYbOxOIr1DXjX29pYWYw5pbmCkC36Lv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7e27d6e778cd87b6f2415515d7127eba53fe5d02:

  Linux 2.6.35-rc3 (2010-06-11 19:14:04 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Jonathan Cameron (1):
      [ARM] mmp: fix build failure due to IRQ_PMU depends on ARCH_PXA

Marek Vasut (2):
      [ARM] pxa/z2: fix missing include in battery driver
      [ARM] pxa/z2: fix flash layout to final version

Robert Jarzmik (1):
      [ARM] pxa/mioa701: fix camera regression

Steve Bennett (1):
      [ARM] pxa: fix incorrect gpio type in udc_pxa2xx.h
