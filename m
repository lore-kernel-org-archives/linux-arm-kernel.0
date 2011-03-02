From: carlv@codeaurora.org (Carl Vanderlip)
Date: Wed,  2 Mar 2011 13:15:42 -0800
Subject: [PATCH 0/4] Initial patches for MSM display update
Message-ID: <1299100542-11120-1-git-send-email-carlv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are the first series of a set of patches to update the MSM display
drivers to support newer MDP versions and display modes (while also providing
a base for future display development). The original source for these patches
is the Google Android kernel tree located here:
http://android.git.kernel.org/kernel/msm.git

Arve Hj?nnev?g (1):
  [ARM] msm_fb: Fix framebuffer console

Dima Zavin (3):
  video: msmfb: Put the partial update magic value into the fix_screen
    struct.
  [ARM] msm: mdp: Add support for RGBX 8888 image format.
  [ARM] msm: mdp: Set the correct pack pattern for XRGB/ARGB

 drivers/video/msm/mdp_hw.h  |   11 +++++++++--
 drivers/video/msm/mdp_ppp.c |    1 +
 drivers/video/msm/msm_fb.c  |   16 ++++++++++++++--
 include/linux/msm_mdp.h     |    1 +
 4 files changed, 25 insertions(+), 4 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
