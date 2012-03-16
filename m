From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Mar 2012 01:44:26 -0400
Subject: [PATCH 0/2] improve debugability of early boot of the kernel
Message-ID: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Especially with the recent rework of static mappings, some people are
stuck with non booting kernels and very little to help them debug it
by themselves.  Turns out that this can be remedied with a patch I posted
a couple months ago, however this version is much improved.

This depends on commit 94e5a85b3be0 "ARM: earlier initialization of vectors
page" that can be found in Russell's tree.

[PATCH 1/2] DEBUG_LL: limit early mapping to the minimum
[PATCH 2/2] remove the debugging restrictions in devicemaps_init()


Nicolas
