From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Nov 2013 19:46:52 +0100
Subject: [PATCH v2 3/4] ata: add APM X-Gene SoC 6.0Gbps SATA PHY driver
In-Reply-To: <CAOS58YMEXhuUApywcOBGh4mFHKhiDJw2pKLN5i80ocvqRX4UiQ@mail.gmail.com>
References: <1384905197-3566-1-git-send-email-lho@apm.com>
 <201311201641.20230.arnd@arndb.de>
 <CAOS58YMEXhuUApywcOBGh4mFHKhiDJw2pKLN5i80ocvqRX4UiQ@mail.gmail.com>
Message-ID: <201311201946.52659.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 November 2013, Tejun Heo wrote:

> On Wed, Nov 20, 2013 at 10:41 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > It needs to be in drivers/phy, which is currently being prepared for
> > the next merge window and which contains the generic interface used
> > in this driver.
> 
> Ah, cool, so I don't need to worry about this one, right?

Right, we just need to make sure the patches are staged the right
way when they go through different subsystem maintainers. There
should not be any build-time dependencies, so I think it won't
be an issue.

	Arnd
