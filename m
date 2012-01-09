From: davidb@codeaurora.org (David Brown)
Date: Mon, 9 Jan 2012 15:34:39 -0800
Subject: [GIT PULL] msm fix for v3.2-rc.
Message-ID: <20120109233439.GA13911@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Small fix that prevented msm7201 from building.

The following changes since commit 805a6af8dba5dfdd35ec35dc52ec0122400b2610:

  Linux 3.2 (2012-01-04 15:55:44 -0800)

are available in the git repository at:
  git://codeaurora.org/quic/kernel/davidb/linux-msm.git msm-fix

there is a signed tag 'davidb-msm-fix'.

David Brown (1):
      ARM: msm: vreg is a module and so needs module.h

 arch/arm/mach-msm/vreg.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
