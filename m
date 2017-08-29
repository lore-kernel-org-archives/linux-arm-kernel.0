From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Tue, 29 Aug 2017 22:08:53 +0200
Subject: [PATCH 0/2] arm: AT91: device-tree fixes for AT91SAM9G45
Message-ID: <cover.1504037038.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two simple fixes for AT91SAM9G45-based board.

Micha? Miros?aw (2):
  arm: AT91: enable ac97 controller for at91sam9g45
  arm: AT91: fix DT duplicate node name

 arch/arm/boot/dts/at91sam9g45.dtsi     | 21 ++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 52 ++++++++++++++++++----------------
 2 files changed, 49 insertions(+), 24 deletions(-)

-- 
2.11.0
