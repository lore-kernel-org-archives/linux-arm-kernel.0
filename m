From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 11 Sep 2015 18:22:19 +0900
Subject: [PATCH 0/2] pinctrl: uniphier: one fix, one addition
Message-ID: <1441963341-1764-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


1/2 is a bug fix, but it is not very critical.
I can wait until 4.4-rc1 if it is a hassle.

2/2 provides some more pin-mux settings.



Masahiro Yamada (2):
  pinctrl: uniphier: fix input enable settings for PH1-sLD8
  pinctrl: uniphier: add SD card pinmux settings

 drivers/pinctrl/uniphier/pinctrl-ph1-ld4.c     |   5 +
 drivers/pinctrl/uniphier/pinctrl-ph1-ld6b.c    |   5 +
 drivers/pinctrl/uniphier/pinctrl-ph1-pro4.c    |  11 ++
 drivers/pinctrl/uniphier/pinctrl-ph1-pro5.c    |   5 +
 drivers/pinctrl/uniphier/pinctrl-ph1-sld8.c    | 230 +++++++++++++------------
 drivers/pinctrl/uniphier/pinctrl-proxstream2.c |   5 +
 6 files changed, 148 insertions(+), 113 deletions(-)

-- 
1.9.1
