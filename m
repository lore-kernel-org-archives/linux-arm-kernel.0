From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue, 17 Sep 2013 10:26:43 +0100
Subject: [PATCH 0/2] Fixes for STi SOCs
Message-ID: <1379410003-9911-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Hi Arnd/Olof, 

These two are very minor fixes for STi SOCs.
One of the fix is a typo and other is to add two new options to
multi_v7_defconfig to get STi SOC based boards boot with nfs root with serial
console.

These patches are based on v3.12-rc1.

Thanks,
srini

Srinivas Kandagatla (2):
  ARM: STi: OF: Fix a typo in pincfg header
  ARM: multi_v7_defconfig: Fix STi support

 arch/arm/boot/dts/st-pincfg.h       |    2 +-
 arch/arm/configs/multi_v7_defconfig |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

-- 
1.7.6.5
