From: l.majewski@samsung.com (Lukasz Majewski)
Date: Wed, 22 Sep 2010 17:30:07 +0200
Subject: [PATCH v2 0/3] mfd: regulator: max8998: BUCK1/2 control augmented by
	GPIO pins
Message-ID: <1285169410-22343-1-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch facilitates the faster voltage change for BUCK1/2 regulators.

Comments and guidlines from Mark Brown have been added.

This patch has been tested at Samsung GONI and AQUILA targets.

Lukasz Majewski (3):
  mfd: regulator: max8998: set_voltage_buck routine added
  mfd: regulator: max8998: probe routine modified for GPIOs use
  mfd: regulator: max8998: mfd code

 drivers/mfd/max8998.c               |    5 +-
 drivers/regulator/max8998.c         |  195 +++++++++++++++++++++++++++++++----
 include/linux/mfd/max8998-private.h |   59 ++++++++++-
 include/linux/mfd/max8998.h         |   14 +++
 4 files changed, 244 insertions(+), 29 deletions(-)
