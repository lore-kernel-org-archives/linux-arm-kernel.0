From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 26 Apr 2017 06:34:21 +0900
Subject: [PATCH 0/2] pinctrl: trivial: remove unneeded (void *) casts in
 of_match_table
Message-ID: <1493156063-8446-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




Masahiro Yamada (2):
  pinctrl: rockchip: remove unneeded (void *) casts in of_match_table
  pinctrl: samsung: remove unneeded (void *) casts in of_match_table

 drivers/pinctrl/pinctrl-rockchip.c        | 20 ++++++++++----------
 drivers/pinctrl/samsung/pinctrl-samsung.c | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.7.4
