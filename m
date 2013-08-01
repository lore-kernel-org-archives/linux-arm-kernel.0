From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu,  1 Aug 2013 13:12:11 +0100
Subject: [PATCH 0/2] ARM: STi: SMP related fixes.
Message-ID: <1375359131-21693-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Hi Anrd/Olof,
These two patches fix a critical SMP issue with STi SOCs. Without this patches
STi SoCs will boot only single core and crashes after freeing the init.

Can you please consider these patches.

Thanks,
srini

Srinivas Kandagatla (2):
  ARM: STi: Fix cpu nodes with correct device_type.
  ARM: STi: remove sti_secondary_start from INIT section.

 arch/arm/boot/dts/stih41x.dtsi |    2 ++
 arch/arm/mach-sti/headsmp.S    |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.6.5
