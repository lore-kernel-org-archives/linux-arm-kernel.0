From: pawel.mikolaj.chmiel@gmail.com (=?UTF-8?q?Pawe=C5=82=20Chmiel?=)
Date: Tue, 17 Jul 2018 20:16:24 +0200
Subject: [PATCH v2 0/2] Input: atmel_mxt_ts: Add support for optional
 regulators
Message-ID: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This two patches add optional regulator support to atmel_mxt_ts.
First patch adds regulators to driver.
Second patch updates documentation.

Changes from v1:
  - Enable regulators only if reset_gpio is present.
  - Switch from devm_regulator_get_optional to devm_regulator_get.

Pawe? Chmiel (2):
  Input: atmel_mxt_ts: Add support for  optional regulators.
  Input: atmel_mxt_ts: Document optional voltage regulators

 .../devicetree/bindings/input/atmel,maxtouch.txt   |  8 ++++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 46 +++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.7.4
