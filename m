From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 19 May 2014 17:11:56 +0200
Subject: [GIT PULL] ARM: STi: SoC changes for v3.16
In-Reply-To: <5375D1A4.2040205@st.com>
References: <5375D1A4.2040205@st.com>
Message-ID: <537A1F3C.90405@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin and Arnd,

Please consider these STi SoC updates for v3.16.

This is now based on v3.15-rc1.

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-soc-for-v3.16

for you to fetch changes up to c6594025c0f8cea2ba089444a359495bd0ea3e6f:

  ARM: STi: Add STiH407 SoC support (2014-05-17 10:22:30 +0200)

----------------------------------------------------------------
SoC changes for STi platforms

----------------------------------------------------------------
Maxime Coquelin (1):
      ARM: STi: Add STiH407 SoC support

 Documentation/arm/sti/stih407-overview.txt    | 18 ++++++++++++++++++
 Documentation/devicetree/bindings/arm/sti.txt | 15 +++++++++++++++
 arch/arm/mach-sti/board-dt.c                  |  1 +
 3 files changed, 34 insertions(+)
 create mode 100644 Documentation/arm/sti/stih407-overview.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sti.txt
