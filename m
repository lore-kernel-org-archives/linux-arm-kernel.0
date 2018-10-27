From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 27 Oct 2018 07:47:34 +0200
Subject: [PATCH 0/8] constify clk_ops structure
Message-ID: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare as const clk_ops structures that are only stored in const fields or
passed to functions with const parameters.

Identified and transformed using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

 arch/arm/mach-vexpress/spc.c             |    2 +-
 drivers/clk/clk-max77686.c               |    2 +-
 drivers/clk/clk-palmas.c                 |    2 +-
 drivers/clk/clk-s2mps11.c                |    2 +-
 drivers/clk/pistachio/clk-pll.c          |    8 ++++----
 drivers/clk/pxa/clk-pxa.c                |    4 ++--
 drivers/gpu/drm/imx/imx-tve.c            |    2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c |    2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)
