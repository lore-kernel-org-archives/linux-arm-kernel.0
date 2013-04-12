From: davidb@codeaurora.org (David Brown)
Date: Fri, 12 Apr 2013 15:43:32 -0700
Subject: [GIT PULL] msm defconfig for 3.10
In-Reply-To: <8ya7gk7qsnp.fsf@huya.qualcomm.com>
Message-ID: <8yavc7rpdyj.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-defconfig-3.10

for you to fetch changes up to dd465b2400a77bea6e5a95045feb6dbcf2e48a38:

  ARM: msm: enable SSBI driver in defconfig (2013-03-12 11:14:32 -0700)

----------------------------------------------------------------
Defconfig updates for MSM

The msm_defconfig is quite out of date.  This allows the targets we
are actively working on to be more easily build and run tested.

----------------------------------------------------------------
David Brown (1):
      ARM: msm: enable SSBI driver in defconfig

Stephen Boyd (1):
      ARM: msm: Concentrate defconfig on DT supported devices

 arch/arm/configs/msm_defconfig | 154 +++++++++++++++++++++++++++++------------
 1 file changed, 109 insertions(+), 45 deletions(-)

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
