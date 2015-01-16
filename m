From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 16 Jan 2015 18:40:11 +0100
Subject: [GIT PULL] ARM: STi: Defconfig changes for v3.20, round 1
Message-ID: <54B94CFB.4000900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi defconfig updates for v3.20.

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

   git://git.stlinux.com/devel/kernel/linux-sti.git 
tags/sti-defconfig-for-v3.20-1

for you to fetch changes up to 89ae11c41e16460d5b259e8059e73f1785f23880:

   ARM: multi_v7_defconfig: Enable MiPHY28lp - ST's Generic (SATA, PCIe 
& USB3) PHY (2015-01-16 13:00:55 +0100)

----------------------------------------------------------------
STi defconfig for v3.20, round 1.

Highlights:
-----------
  - Enable STiH407 USB PicoPHY in multi_v7_defconfig
  - Enable MiPHY28lp driver in multi_v7_defconfig

----------------------------------------------------------------
Gabriel FERNANDEZ (1):
       ARM: multi_v7_defconfig: Enable MiPHY28lp - ST's Generic (SATA, 
PCIe & USB3) PHY

Peter Griffin (1):
       ARM: multi_v7_defconfig: Enable stih407 usb picophy

  arch/arm/configs/multi_v7_defconfig | 2 ++
  1 file changed, 2 insertions(+)
