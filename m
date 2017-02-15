From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Feb 2017 14:54:15 +0000
Subject: [PATCH 0/2] arm64: head.S cleanup
Message-ID: <1487170457-17986-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While looking at head.S, I saw that over time we've grown some
convoluted code paths that can be simplified.

These patches clean those up.

Thanks,
Mark.

Mark Rutland (2):
  arm64: reduce el2_setup branching
  arm64: move !VHE work to end of el2_setup

 arch/arm64/kernel/head.S | 52 ++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

-- 
1.9.1
