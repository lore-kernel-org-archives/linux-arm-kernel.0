From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 17:51:03 +0530
Subject: [PATCH 0/3] ARM: SPEAr3xx: Minor fixes for spear3xx machine
Message-ID: <cover.1342181727.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to fix:
-spear320 compatible string
-spear320 no of pinmux modes.
-spear3xx gpt timer parent clk id.

Vipul Kumar Samar (3):
  ARM: SPEAr3xx: Rename gpt timer clk parent name
  ARM: dts: SPEAr320: Fix compatible string
  ARM: dts: SPEAr320: Fix no. of supported pinmux mode

 arch/arm/boot/dts/spear320-evb.dts |    4 ++--
 arch/arm/mach-spear3xx/spear3xx.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.2.2
