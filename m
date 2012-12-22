From: mikedunn@newsguy.com (Mike Dunn)
Date: Sat, 22 Dec 2012 10:27:38 -0800
Subject: [PATCH 0/2] ARM: pxa: palm27x: device initialization fixes
Message-ID: <1356200860-3241-1-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I/ve been working on getting the kernel running smoothly on my palm treo 680.
To start, here are a couple short patches that fix problems with udc and lcd
device initialization.  Thanks for looking.  Happy holidays!

Mike Dunn (2):
  ARM: pxa: palm27x: fix udc device initialization
  ARM: pxa: palm27x: fix lcd device initialization

 arch/arm/mach-pxa/palm27x.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

-- 
1.7.8.6
