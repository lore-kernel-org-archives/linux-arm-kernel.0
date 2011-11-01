From: davidb@codeaurora.org (David Brown)
Date: Tue, 1 Nov 2011 16:14:30 -0700
Subject: [GIT PULL] msm fix: fixup machine_desc missed in merge
Message-ID: <20111101231429.GA3446@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b4beb4bf9934d151bf4581a54ae028927374cb2a:

  Merge branch 'for-linus/i2c-3.2' of git://git.fluff.org/bjdooks/linux (2011-11-01 15:07:19 -0700)

are available in the git repository at:

  git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-fix

Stephen Boyd (1):
      msm: boards: Fix fallout from removal of machine_desc in fixup

 arch/arm/mach-msm/board-msm7x30.c |    4 ++--
 arch/arm/mach-msm/board-msm8960.c |    4 ++--
 arch/arm/mach-msm/board-msm8x60.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111101/fbb05118/attachment.sig>
