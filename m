From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Sep 2012 08:18:37 +0900
Subject: [GIT PULL 2/7] Samsung gpio for v3.7
Message-ID: <099901cd96bd$1929fd60$4b7df820$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

This is for supporting DT gpio for Samsung S3C24XX.

Since there are many changes for gpio-samsung in my tree, this has been
included in my tree with Linus' agreement.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/gpio-samsung

Heiko Stuebner (1):
      gpio: samsung: add devicetree init for s3c24xx arches

 .../devicetree/bindings/gpio/gpio-samsung.txt      |   43 +++++++++++++
 drivers/gpio/gpio-samsung.c                        |   63
++++++++++++++++++++
 2 files changed, 106 insertions(+), 0 deletions(-)
