From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Thu, 15 Mar 2018 09:06:01 +0000
Subject: [GIT PULL] STi DT update for v4.17 round 2
Message-ID: <af473935-7cb6-e59a-3b52-055d8492248c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

PLease consider this second round of STi dts update for v4.17

The following changes since commit 0e04ce02e6a2ac30d21294d8bb2aeceb8489e52b:

   ARM: dts: STi: Remove unused clk_ext2f_a9 clock (2018-02-13 13:31:38 
+0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git

for you to fetch changes up to 9a5f4879cd8de167e82f335317c63f2ffdc80129:

   ARM: dts: stih4xx: Add missing #sound-dai-cells (2018-03-15 09:52:25 
+0100)

----------------------------------------------------------------

STi DT update:

Add missing #sound-dai-cells which fix DT dtc warnings when building 
with W=1

----------------------------------------------------------------
Rob Herring (1):
       ARM: dts: stih4xx: Add missing #sound-dai-cells

  arch/arm/boot/dts/stih407.dtsi | 1 +
  arch/arm/boot/dts/stih410.dtsi | 1 +
  2 files changed, 2 insertions(+)
