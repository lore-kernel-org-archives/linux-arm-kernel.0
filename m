From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Nov 2012 09:14:59 +0900
Subject: [GIT PULL 1/7] Samsung fixes for v3.7
Message-ID: <50B55783.3020509@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

I sorted out my branches as per Olof's suggestion

It includes a fix for v3.7 but I think this is not a critical so it's ok 
to me for v3.8.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.7-samsung-fixes-4

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
v3.7-samsung-fixes-4

Sachin Kamat (1):
       ARM: S3C24XX: Fix potential NULL pointer dereference error

  arch/arm/plat-s3c24xx/dma.c |    9 +++++----
  1 files changed, 5 insertions(+), 4 deletions(-)
