From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 28 Sep 2015 19:50:43 +0300
Subject: [PATCH 0/4] memory: pl17x: add support of PL175 and PL176 controllers
Message-ID: <1443459043-24144-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds support of ARM PrimeCell PL175 MPMC and PL176 MPMC,
the static memory controllers on devices are similar to one found on
ARM PrimeCell PL172, add support to the existing driver.

Vladimir Zapolskiy (4):
  memory: pl172: correct MPMC peripheral ID register bits
  memory: pl172: add ARM PrimeCell PL175 MPMC support
  memory: pl172: add ARM PrimeCell PL176 MPMC support
  doc: dt: arm,pl172: add description of PL175 and PL176 controllers

 .../bindings/memory-controllers/arm,pl172.txt      |  8 ++++---
 drivers/memory/pl172.c                             | 26 +++++++++++++++++++---
 2 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.1.4
