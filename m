From: horms@verge.net.au (Simon Horman)
Date: Thu, 14 Oct 2010 18:12:31 +0900
Subject: [patch v3 0/2] ARM: mach-shmobile: Add zboot support for SuperH
	Mobile ARM
Message-ID: <20101014091231.858799238@vergenet.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short patch series by Kuninori Morimoto and myself adds
zboot support to mach-shmobile.

This is v3 of this patch series. It implements Magnus's suggestion
of initialising atags directly rather than using assembly.

v2 implemented Magnus's suggestion of setting atags in the framework and
passing them to the kernel rather than using a board-specific fixup.
