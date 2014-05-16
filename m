From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 16 May 2014 10:53:15 +0200
Subject: [GIT PULL] ARM: STi: SoC changes for v3.16
In-Reply-To: <5375D1A4.2040205@st.com>
References: <5375D1A4.2040205@st.com>
Message-ID: <5375D1FB.6040309@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Kevin and Arnd,

Please consider these STi SoC updates for v3.16.

The following changes since commit 0db543faecf3ebfc3a4e5cafb61ca6b219820bba:

   Merge tag 'renesas-soc2-for-v3.16' of 
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into 
next/soc (2014-05-05 18:45:10 -0700)

are available in the git repository at:


   git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-soc-for-v3.16

for you to fetch changes up to e9d71b9fdb5dd5395ee011841967068a6167084f:

   ARM: STi: Add STiH407 SoC support (2014-05-13 18:49:32 +0200)

----------------------------------------------------------------
Maxime Coquelin (1):
       ARM: STi: Add STiH407 SoC support

  Documentation/arm/sti/stih407-overview.txt    | 18 ++++++++++++++++++
  Documentation/devicetree/bindings/arm/sti.txt | 15 +++++++++++++++
  arch/arm/mach-sti/board-dt.c                  |  1 +
  3 files changed, 34 insertions(+)
  create mode 100644 Documentation/arm/sti/stih407-overview.txt
  create mode 100644 Documentation/devicetree/bindings/arm/sti.txt
