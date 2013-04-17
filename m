From: cedric@precidata.com (Cedric Berger)
Date: Wed, 17 Apr 2013 22:42:48 +0200 (CEST)
Subject: [PATCH 0/10] LPC32XX: Various patches and improvements
Message-ID: <mailman.14.1366231411.1198.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a patchset that improve support for various features of the
LPC32XX on linux. The most important are the first two patches, which
enable MMC+DMA on that controller. These patches have been tested
against 3.9rc7 on our LPC32XX board, but should benefit most boards
using the LPC32XX.

Cedric Berger
cedric at precidata.com
