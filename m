From: ecc@cmu.edu (Eric Cooper)
Date: Tue,  3 Aug 2010 18:13:23 -0400
Subject: [PATCH] support for Seagate DockStar
Message-ID: <1280873604-3065-1-git-send-email-ecc@cmu.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is a patch to support the Seagate FreeAgent DockStar, a Marvell
Sheevaplug derivative.  I have already registered the DOCKSTAR machine
ID. (The change to arch/arm/tools/mach-types is only needed to get
this to compile and can be ignored once mach-types is updated from the
official list.)
