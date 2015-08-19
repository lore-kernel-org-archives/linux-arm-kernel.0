From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed, 19 Aug 2015 10:48:12 +0200
Subject: [PATCH 0/2] ST PLL fixes for 4.3
Message-ID: <1439974094-32322-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Should be apply with 
commit 5eb26c605909 ("ARM: STi: DT: Rename st_pll3200c32_407_c0_x into st_pll3200c32_cx_x")
to avoid broken compatibility.

Gabriel Fernandez (2):
  dt-bindings: Fix tipo in st,clkgen-pll documentation
  drivers: clk: st: Rename st_pll3200c32_407_c0_x into
    st_pll3200c32_cx_x

 Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt |  4 ++--
 drivers/clk/st/clkgen-fsyn.c                                 |  8 ++++----
 drivers/clk/st/clkgen-pll.c                                  | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
1.9.1
