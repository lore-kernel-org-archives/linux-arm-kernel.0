From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 18 Nov 2014 15:07:31 +0100
Subject: [GIT PULL] ARM: STi: defconfig changes for v3.19, round 1
Message-ID: <546B52A3.7020908@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi defconfig updates for v3.19 :

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

   git://git.stlinux.com/devel/kernel/linux-sti.git 
tags/sti-defconfig-for-v3.19-1

for you to fetch changes up to 1d5b8b621e31e46f82ed9254af9cd1faa5b81dbb:

   ARM: multi_v7_defconfig: Enable stih415/6 usb2 phy driver. 
(2014-11-18 13:38:16 +0100)

----------------------------------------------------------------
STi defconfig updates for v3.19

Highlights:
-----------
  - Enable ST EHCI and OHCI USB drivers
  - Enable STiH416 and STiH415 USB2 PHY driver

----------------------------------------------------------------
Peter Griffin (2):
       ARM: multi_v7_defconfig: Enable st ohci and ehci HCD drivers.
       ARM: multi_v7_defconfig: Enable stih415/6 usb2 phy driver.

  arch/arm/configs/multi_v7_defconfig | 3 +++
  1 file changed, 3 insertions(+)
