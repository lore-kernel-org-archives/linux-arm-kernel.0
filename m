From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 19 Apr 2014 18:32:48 +0200
Subject: [PATCH 0/2] ARM: mvebu: board-v7 cleanup
Message-ID: <1397925170-8202-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches doesn't really change the behaviour of the code, but
will help to make it more readable and maintainable.

Thanks

Gregory CLEMENT (2):
  ARM: mvebu: remove unnecessary ifdef around l2x0_of_init
  ARM: mvebu: fix the name of the parameter used in mvebu_get_soc_id

 arch/arm/mach-mvebu/board-v7.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
1.8.1.2
