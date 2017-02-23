From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 23 Feb 2017 11:21:19 +0000
Subject: [GIT PULL] arm64: dts: juno: fixes for v4.11
Message-ID: <00e4e03a-7d74-d7ac-ca55-21311071ed66@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC Team,

Sorry for sending fixes during the merge window. Since I will be off for
next 2 weeks, I am sending in advance. For that reason, it's based on my
earlier juno updates that I sent for v4.11. Please pull at your ease.

-- 
Regards,
Sudeep

The following changes since commit 1492a864364ed46be2abeaaaf3b1a248f19e6644:

  arm64: dts: juno: remove motherboard USB node (2017-01-18 14:01:20 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
tags/juno-fixes-4.11

for you to fetch changes up to 7e6a69ee954caf8dd8c98f70c8ee894c8ebfdcf0:

  arm64: dts: juno: update definition for programmable replicator
(2017-02-21 16:02:02 +0000)

----------------------------------------------------------------
ARMv8 Juno DT fix for v4.11

Just single patch to fix replicator in order to prevent overflows at
the source and reduce the back pressure by splitting the trace output
to TPIU and ETR.

----------------------------------------------------------------
Mike Leach (1):
      arm64: dts: juno: update definition for programmable replicator

 arch/arm64/boot/dts/arm/juno-base.dtsi | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)
