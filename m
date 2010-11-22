From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Nov 2010 08:15:14 +0900
Subject: [patch v4 0/2] ARM: mach-shmobile: Add zboot support for SuperH
	Mobile ARM
Message-ID: <20101122231514.766413220@vergenet.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short patch series by Kuninori Morimoto and myself adds
zboot support to mach-shmobile.

This is v4 of the patch series, which includes
a minor rediff to apply cleanly against linux-2.6-arm/devel
without any fuzz.

v2 implemented Magnus's suggestion to initialising atags directly rather
than using assembly.

v2 implemented Magnus's suggestion of setting atags in the framework and
passing them to the kernel rather than using a board-specific fixup.
