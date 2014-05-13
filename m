From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue, 13 May 2014 13:57:31 +0200
Subject: [RFC] [PATCH 0/2] clock helper for determining flags properties
Message-ID: <1399982253-21079-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch provides a helper to get flags properties of a clock node.
This patch is limited to CLK_SET_RATE_PARENT flag for e.g.

The second patch provides an example of use of this clock helper.

Gabriel Fernandez (2):
  clk: of: helper for determining flags properties
  drivers: clk: st: authorize propagate rate change for clockgenD0

 arch/arm/boot/dts/stih407-clock.dtsi |  1 +
 drivers/clk/clk.c                    | 11 +++++++++++
 drivers/clk/st/clk-flexgen.c         |  2 ++
 include/linux/clk-provider.h         |  6 ++++++
 4 files changed, 20 insertions(+)

-- 
1.9.1
