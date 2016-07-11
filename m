From: patrice.chotard@st.com (Patrice Chotard)
Date: Mon, 11 Jul 2016 10:29:44 +0200
Subject: [GIT PULL v2] STi defconfig updates for v4.8
Message-ID: <578358F8.3070303@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of multi_v7_defconfig updates for v4.8:

The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:

   Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git 
tags/sti-defconfig-for-v4.8

for you to fetch changes up to afd9dc4562c5838323a3909cc717a8617307c253:

   ARM: multi_v7_defconfig: enable STMicroelectronics DRM Support 
(2016-07-11 09:42:59 +0200)

----------------------------------------------------------------
warning: refname 'sti-defconfig-for-v4.8' is ambiguous.
Highlights:
-----------
- Enable DRM_STI for STMicroelectronics DRM Support
- VIDEO_STI_BDISP for STMicroelectronics BDISP 2D

----------------------------------------------------------------
Patrice Chotard (2):
       ARM: multi_v7_defconfig: enable STMicroelectronics BDISP 2D 
blitter driver
       ARM: multi_v7_defconfig: enable STMicroelectronics DRM Support

  arch/arm/configs/multi_v7_defconfig | 2 ++
  1 file changed, 2 insertions(+)
