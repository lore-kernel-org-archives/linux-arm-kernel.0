From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Mar 2013 20:50:36 +0000
Subject: [GIT PULL 3/3] ARM: mvebu: soc for v3.10
In-Reply-To: <20130318171824.44814271@skate>
References: <1363551341.10D8ED563.32562@triton>
 <20130318010726.GF13280@titan.lakedaemon.net> <20130318171824.44814271@skate>
Message-ID: <201303182050.36925.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 March 2013, Thomas Petazzoni wrote:
> > Please just send a new version of the mv78xx0 patch.  No need for a new
> > series.
> 
> Seeing the discussion with Arnd, it seems like a new series will be
> needed. Not because of mv78xx0, but because Arnd wants a non-DT driver.

You could do the patch to remove the DT binding on top if that makes your
life easier, as long it's gone by the time of the merge window.

	Arnd
