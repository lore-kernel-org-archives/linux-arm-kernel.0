From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 28 Jun 2016 13:17:15 -0600
Subject: [PATCH REBASE 0/3] Rebased on linuxtv/master 
Message-ID: <cover.1467140929.git.shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rebased on linuxtv/master latest with the top commit:
commit 80aa26593e3eb48f16c4222aa27ff40806f57c45
Author: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed May 11 11:02:53 2016 -0300

Shuah Khan (3):
  media: s5p-mfc fix video device release double release in probe error
    path
  media: s5p-mfc fix memory leak in s5p_mfc_remove()
  media: s5p-mfc fix null pointer deference in clk_core_enable()

 drivers/media/platform/s5p-mfc/s5p_mfc.c    |  4 ++--
 drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 12 +++++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.7.4
