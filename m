From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 May 2013 10:54:01 +0200
Subject: [PATCH for 3.10-rc] ARM: mvebu: Fix bug in coherency fabric low level
 init function
Message-ID: <1369299242-16506-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason and Andrew,

This a new fix for 3.10-rc coming from Marvell. I wasn't impacted
(until now) by the bug fixed by this commit, but I trust Nadav with
his patch, and I didn't see any flaw in his code. Furthermore, I
applied and tested it and saw no regression.

So please applied it for 3.10-rc and we can also consider to applied
it to 3.8 and 3.9.

Thanks

Nadav Haklai (1):
  ARM: mvebu: Fix bug in coherency fabric low level init function

 arch/arm/mach-mvebu/coherency_ll.S | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
1.8.1.2
