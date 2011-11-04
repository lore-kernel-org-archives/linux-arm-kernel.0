From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Nov 2011 14:00:43 +0100
Subject: arm-soc samsung patches blocked on dmaengine patches
Message-ID: <201111041400.44486.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod and Kukjin,

Right now, all the patches from the arm-soc tree are merged into 3.2, but the
samsung/cleanup and samsung/devel series are missing because they depend on
patches in the dmaengine tree. I'm not sure about the status of that tree,
but I didn't see a pull request for them yet.

Should I just submit the samsung tree with the dmaengine patches included,
or keep waiting?

	Arnd
