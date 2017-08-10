From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu, 10 Aug 2017 12:06:12 +0200
Subject: [PATCH 00/17] constify pinconf_ops, pinctrl_ops,
 and pinmux_ops structures
Message-ID: <1502359589-15970-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These structures are only stored in fields of a pinctrl_desc
structure that are const. Make the structures const as well.

Done with the help of Coccinelle.

---

 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c  |    4 ++--
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c  |    6 +++---
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c      |    2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |    2 +-
 drivers/pinctrl/pinctrl-adi2.c              |    4 ++--
 drivers/pinctrl/pinctrl-artpec6.c           |    2 +-
 drivers/pinctrl/pinctrl-digicolor.c         |    4 ++--
 drivers/pinctrl/pinctrl-ingenic.c           |    6 +++---
 drivers/pinctrl/pinctrl-rza1.c              |    2 +-
 drivers/pinctrl/pinctrl-st.c                |    6 +++---
 drivers/pinctrl/pinctrl-tb10x.c             |    4 ++--
 drivers/pinctrl/pinctrl-tz1090-pdc.c        |    6 +++---
 drivers/pinctrl/pinctrl-tz1090.c            |    6 +++---
 drivers/pinctrl/sirf/pinctrl-atlas7.c       |    2 +-
 drivers/pinctrl/sirf/pinctrl-sirf.c         |    4 ++--
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c     |    4 ++--
 drivers/pinctrl/vt8500/pinctrl-wmt.c        |    6 +++---
 17 files changed, 35 insertions(+), 35 deletions(-)
