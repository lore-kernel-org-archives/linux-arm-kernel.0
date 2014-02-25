From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 25 Feb 2014 11:03:45 +0100
Subject: [PATCH 0/2] regulator: core: always_on fixups
Message-ID: <1393322627-26543-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The second patch adds a check for dummy regulators that are not always_on. The
first patch adds a always_on constraint to the dummy regulator.

Regards,

Markus


Markus Pargmann (2):
  regulator: dummy: Should be always-on
  regulator: core: Error on not always_on dummy regulators

 drivers/regulator/core.c  | 27 ++++++++++++++++++++++++---
 drivers/regulator/dummy.c |  6 +++++-
 2 files changed, 29 insertions(+), 4 deletions(-)

-- 
1.8.5.3
