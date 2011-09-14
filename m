From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Sep 2011 01:41:40 -0400
Subject: [PATCH 0/6] zImage improvements with DTB append and ATAG compatibility
Message-ID: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the latest incarnation of my patch series allowing a DTB
to be appended to zImage, including the ATAG conversion wrapper and
other minor cleanups.

This can also be pulled from:

	git://git.linaro.org/people/nico/linux zImage_DTB_append

This works for me on the test setup I have.
ACKs/Tested-By's would be appreciated.  




Nicolas
