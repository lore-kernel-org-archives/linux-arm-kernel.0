From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 21 Oct 2012 14:36:52 +0200
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA012D8@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <20121020141136.GA6433@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
 <20121021073551.GA4735@netboy.at.omicron.at>
 <C8443D0743D26F4388EA172BF4E2A7A93EA012D8@DBDE01.ent.ti.com>
Message-ID: <20121021123652.GA15421@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2012 at 12:29:26PM +0000, Mohammed, Afzal wrote:
> Hi Richard,
> 
> * Richard Cochran, October 21, 2012 1:05 PM:
> 
> > People keep saying, the beaglebone works fine with v3.7-rc1, but it
> > isn't true. Now v3.7-rc2 is out, and the gpmc issue still has not been
> > fixed, and no one is doing anything about it either.
> 
> A fix to resolve the gpmc issue has been merged recently, so I am
> expecting beagle bone to boot on -rc2 (I don't have hardware to test,
> on vacation now), can you please try with -rc2.

I am happy to report that v3.7-rc2 boots via the modern DT method,
using Paul's am33xx_only config and U-Boot 2012.10-rc1-00148-g4668a08.

Thanks, and have a nice vacation,
Richard
