From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Dec 2012 10:16:25 -0800
Subject: [PATCH v2 0/7] Updates for Zynq's timer driver
Message-ID: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I started to put some effort on syncing the Xilinx Linux tree with mainline and
the timer driver is my first victim.
Most commits are fixing style issues or clean up. Functionality is touched only
in patches #2 and #7.

Some patches are present in almost identically in the Xilinx Linux tree and I
took over 'Acked-by' lines from those commits.

To repost the patch with the arm-kernel list included I made this a v2 to avoid
confusion about which series is the current one, though the patches are the same
as the ones posted before on lkml only.
I added Josh's 'Reviewed-by' line though.

v2:
 - extend receipient list
 - adding reviewed by lines to commit messages

	Soren


Soren Brinkmann (7):
  arm: zynq: timer: Replace PSS through PS
  arm: zynq: timer: Remove unnecessary register write
  arm: zynq: timer: Remove unused #defines
  arm: zynq: timer: Align columns
  arm: zynq: timer: Remove redundant #includes
  arm: zynq: timer: Fix comment style
  arm: zynq: timer: Set clock_event cpumask

 arch/arm/mach-zynq/common.c |   6 +-
 arch/arm/mach-zynq/common.h |   2 +-
 arch/arm/mach-zynq/timer.c  | 150 +++++++++++++++++++++-----------------------
 3 files changed, 75 insertions(+), 83 deletions(-)

-- 
1.8.0.2
