From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Fri, 13 Jul 2018 20:30:06 +0200
Subject: [PATCH 0/2] Input: atmel_mxt_ts: Add support for optional regulators
Message-ID: <1531506608-24479-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This two patches add optional regulator support to atmel_mxt_ts.
First patch adds regulators to driver.
Second patch updates documentation.

Pawe? Chmiel (2):
  Input: atmel_mxt_ts: Add support for  optional regulators.
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../devicetree/bindings/input/atmel,maxtouch.txt   |  8 ++++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 45 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)

-- 
2.7.4
