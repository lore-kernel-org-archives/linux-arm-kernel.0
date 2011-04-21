From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Apr 2011 01:02:39 -0700
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <20110420073445.GB31127@S2100-06.ap.freescale.net>
References: <20110324231830.2586.7150.stgit@riker>
	<20110328091259.GA18721@S2100-06.ap.freescale.net>
	<20110413140030.GE12665@atomide.com>
	<20110420054746.GA31127@S2100-06.ap.freescale.net>
	<20110420073445.GB31127@S2100-06.ap.freescale.net>
Message-ID: <20110421080238.GE13688@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo <shawn.guo@freescale.com> [110420 00:27]:
> On Wed, Apr 20, 2011 at 01:47:47PM +0800, Shawn Guo wrote:
> > I would like to confirm it fixes your setup before I send fixing
> > patch to remove 'static' from global variables in all platform
> > uncompress.h.
> > 
> Just saw Nico's patch, so ignore above lines ...

Thanks looks like removing static only changes things so now
"Warning: Neither atags nor dtb found" error message printed out.

Regards,

Tony
