From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 17 Jul 2013 10:10:12 -0700
Subject: [PATCH 0/3] arm: zynq: SLCR clean up
Message-ID: <1374081015-31431-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are just a few patches cleaning up the driver - well at least I
find it cleaner this way.
3/3 though adds correct read-modify-write for some register accesses.
The current implementation doesn't seem to do any harm, but this looks
better, IMHO.

	S?ren

Soren Brinkmann (3):
  arm: zynq: slcr: Remove redundant header #includes
  arm: zynq: slcr: Clean up #defines
  arm: zynq: slcr: Use read-modify-write for register writes

 arch/arm/mach-zynq/slcr.c | 45 +++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

-- 
1.8.3.3
