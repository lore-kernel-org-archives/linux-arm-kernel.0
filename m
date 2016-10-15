From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 15 Oct 2016 19:32:00 +0200
Subject: [PATCH 0/2] constify i2c_adapter_quirks structures
Message-ID: <1476552722-12352-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Constify i2c_adapter_quirks structures.

---

 drivers/i2c/busses/i2c-axxia.c      |    2 +-
 drivers/i2c/busses/i2c-bcm-iproc.c  |    2 +-
 drivers/i2c/busses/i2c-dln2.c       |    2 +-
 drivers/i2c/busses/i2c-viperboard.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
