From: rabel@cit-ec.uni-bielefeld.de (Robert ABEL)
Date: Thu, 12 Feb 2015 18:13:29 +0100
Subject: [PATCH] ARM OMAP2 GPMC undefines DEBUG
Message-ID: <1423761210-24452-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPMC driver in OMAP2 undef's DEBUG, which makes it unnecessarily hard to turn DEBUG on,
because that's not expected behavior.
My proposed patch gets rid of the line undef'ing DEBUG.

Robert ABEL (1):
  ARM OMAP2 GPMC: don't undef DEBUG

 arch/arm/mach-omap2/gpmc.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.3.0
