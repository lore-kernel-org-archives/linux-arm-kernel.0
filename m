From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 31 May 2010 12:25:01 +0800
Subject: [GIT PULL] pxa: fixes for v2.6.34-rc1
Message-ID: <AANLkTillgu4x49AMo9f6NMmmZvoMQRFaenfwi9d62W__@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:
  Linus Torvalds (1):
        Linux 2.6.35-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Marek Vasut (1):
      [ARM] pxa/spitz: Correctly register WM8750

Tobias Klauser (1):
      [ARM] pxa/palmtc: storage class should be before const qualifier

 arch/arm/mach-pxa/palmtc.c |    4 ++--
 arch/arm/mach-pxa/spitz.c  |    3 +++
 sound/soc/pxa/spitz.c      |   36 ------------------------------------
 3 files changed, 5 insertions(+), 38 deletions(-)
