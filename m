From: patrice.chotard@st.com (Patrice Chotard)
Date: Fri, 1 Jul 2016 16:08:08 +0200
Subject: [GIT PULL] STi defconfig updates for v4.8
Message-ID: <57767948.6090009@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this round of STi defconfig updates for v4.8:


The following changes since commit 4c2e07c6a29e0129e975727b9f57eede813eea85:

   Linux 4.7-rc5 (2016-06-26 17:52:03 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
sti-defconfig-for-v4.8

for you to fetch changes up to 15f82341a7cbb70ab5a7aee3c717204a9fc11722:

   ARM: multi_v7_defconfig: enable STMicroelectronics DRM Support 
(2016-07-01 16:00:50 +0200)

----------------------------------------------------------------
Patrice Chotard (2):
       ARM: multi_v7_defconfig: enable STMicroelectronics BDISP 2D 
blitter driver
       ARM: multi_v7_defconfig: enable STMicroelectronics DRM Support

  arch/arm/configs/multi_v7_defconfig | 2 ++
  1 file changed, 2 insertions(+)
