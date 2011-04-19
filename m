From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 19 Apr 2011 15:50:10 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <201104191616.01647.arnd@arndb.de>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<BANLkTikVfdVQuR_nJZnra7Bo=CQgOfS5Zg@mail.gmail.com>
	<20110415062643.GB12272@atomide.com>
	<201104191616.01647.arnd@arndb.de>
Message-ID: <20110419145009.GH9462@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 04:16:01PM +0200, Arnd Bergmann wrote:

> That sounds like a good idea. Same for the regulator drivers that are
> currently in arch/arm instead of drivers/regulator.

We don't have any regulator drivers in arch/arm I think (unless the ST
one got merged, but that's actually a dual regulator/system management
driver rather than a proper regulator - when I reviewed it I didn't flag
the location due to the second interface on the side).
