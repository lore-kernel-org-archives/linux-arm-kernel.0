From: singhalsimran0@gmail.com (simran singhal)
Date: Sat,  4 Mar 2017 22:16:52 +0530
Subject: [PATCH 0/3] staging: Clean up tests if NULL returned on failure
Message-ID: <1488646015-7059-1-git-send-email-singhalsimran0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series tests if functions like kmalloc/kzalloc return NULL
on failure. When NULL represents failure, !x is commonly used.

simran singhal (3):
  staging: rtl8192u: Clean up tests if NULL returned on failure
  staging: speakup: Clean up tests if NULL returned on failure
  staging: vc04_services: Clean up tests if NULL returned on failure

 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c      | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c       | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c         | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c              | 4 ++--
 drivers/staging/speakup/main.c                                 | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.4
