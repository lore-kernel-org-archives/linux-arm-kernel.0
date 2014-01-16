From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 16 Jan 2014 09:06:23 +0100
Subject: [PATCHv2 0/2] pwm: imx: support polarity inversion
Message-ID: <1389859585-14006-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch does a minor source cleanup without any functional
change.

Changes wrt. v1:
- make PWM_POLARITY flag optional, so that the driver will work
  with either the existing DT binding or with support for polarity
  inversion.
