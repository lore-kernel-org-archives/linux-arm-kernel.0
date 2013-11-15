From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Nov 2013 13:52:33 +0100
Subject: [PATCH 1/3] Documentation: Add APM X-Gene SoC 6.0Gbps SATA PHY
 driver binding documentation
In-Reply-To: <201311151335.09577.arnd@arndb.de>
References: <1384457519-21335-1-git-send-email-lho@apm.com>
 <1384457519-21335-2-git-send-email-lho@apm.com>
 <201311151335.09577.arnd@arndb.de>
Message-ID: <201311151352.33803.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013, Arnd Bergmann wrote:
> On Thursday 14 November 2013, Loc Ho wrote:
> > +- id                   : PHY ID (0 = first, 1 = second, 2 = third)
> > +- #phy-cells           : Shall be 0
> 
> Hmm, it seems like this would make more sense if you have #phy-cells=<1>
> and have the PHY ID in user node as the argument.

Ignore this comment. After reading patch 2, I concluded that your choice of
#phy-cells=0 is probably more appropriate here.

	Arnd
