From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 11:53:43 +0530
Subject: [PATCH 0/4] clk:spear: Rename clk ids within predefined limit
Message-ID: <cover.1342160220.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The max limit of con_id is 16 and dev_id is 20. As of now for all SPEAr SOC's
clk ids are exceeding this predefined limit.
 
This patch set is intended to rename clk ids through out spear clk framework.

Vipul Kumar Samar (4):
  clk:spear1340:Fix: Rename clk ids within predefined limit
  clk:spear1310:Fix: Rename clk ids within predefined limit
  Clk:spear3xx:Fix: Rename clk ids within predefined limit
  Clk:spear6xx:Fix: Rename clk ids within predefined limit

 drivers/clk/spear/spear1310_clock.c |  312 +++++++++++++++++------------------
 drivers/clk/spear/spear1340_clock.c |  273 +++++++++++++++---------------
 drivers/clk/spear/spear3xx_clock.c  |  180 ++++++++++-----------
 drivers/clk/spear/spear6xx_clock.c  |  122 +++++++-------
 4 files changed, 436 insertions(+), 451 deletions(-)

-- 
1.7.2.2
