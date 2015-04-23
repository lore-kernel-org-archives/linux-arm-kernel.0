From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 23 Apr 2015 13:06:03 -0700
Subject: [PATCH arm 0/2] Fixes for ARM use of scheduler when offline
Message-ID: <20150423200603.GA9473@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

This series is strictly FYI.

I am simply sending it as a heads-up.  The diagnostics surrounding using
RCU from an offline CPU will be tightening up, which might cause splats
to come my way.  If such splats do come my way, I will reply with the
patches in this series.

I know you guys have been working to put something better together,
which is great -- just letting you know of fallback patches, when and if.
If you would like to push these up your tree or ack them and have me
push them, that is of course fine as well.

The first patch in the series does arm64, and the second does arm.

							Thanx, Paul

------------------------------------------------------------------------

 b/arch/arm/kernel/smp.c   |    6 ++----
 b/arch/arm64/kernel/smp.c |    6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)
