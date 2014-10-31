From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 31 Oct 2014 15:12:10 +0100
Subject: [GIT PULL] STi: Reset changes for v3.19
Message-ID: <545398BA.8040601@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

Please consider these STi reset updates for v3.19:

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

   git://git.stlinux.com/devel/kernel/linux-sti.git 
tags/sti-reset-for-v3.19-1

for you to fetch changes up to 4b171b3d3bdf256b0d75a6b3430d8b73134b1bf7:

   reset: sti: Document sti-picophyreset controllers bindings. 
(2014-10-31 13:00:38 +0100)

----------------------------------------------------------------
STi reset controller updates for v3.19.

This tag adds support to STiH407 reset controllers:
   1. st,stih407-powerdown
   2. st,stih407-softreset
   3. st,stih407-picophyreset

----------------------------------------------------------------
Maxime Coquelin (1):
       reset: stih407: Add reset controllers DT bindings

Peter Griffin (2):
       reset: stih407: Add softreset, powerdown and picophy controllers
       reset: sti: Document sti-picophyreset controllers bindings.

  .../bindings/reset/st,sti-picophyreset.txt         |  42 ++++++
  drivers/reset/sti/Kconfig                          |   4 +
  drivers/reset/sti/Makefile                         |   1 +
  drivers/reset/sti/reset-stih407.c                  | 158 
+++++++++++++++++++++
  .../dt-bindings/reset-controller/stih407-resets.h  |  61 ++++++++
  5 files changed, 266 insertions(+)
  create mode 100644 
Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
  create mode 100644 drivers/reset/sti/reset-stih407.c
  create mode 100644 include/dt-bindings/reset-controller/stih407-resets.h
