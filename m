From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 Nov 2012 09:16:03 +0900
Subject: [GIT PULL 5/7] Samsung pinctrl-2 for v3.8
Message-ID: <50B557C3.4040502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is updating Samsung pinctrl for v3.8 and actually just including 
fix a checkpatch error.

This is based on next/pinctrl-samsung is already into arm-soc tree.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/pinctrl-samsung-2

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 4a991b410cd7940c48f261e854e8698923e23fd2:

   pinctrl: samsung: Update error check for unsigned variables 
(2012-11-19 10:03:35 +0900)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/pinctrl-samsung-2

Sachin Kamat (1):
       pinctrl: samsung: Do not initialise statics to 0

  drivers/pinctrl/pinctrl-samsung.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)
