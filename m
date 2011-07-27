From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Jul 2011 18:33:57 +0200
Subject: [PATCH v2] ARM: tegra: only select MACH_HAS_SND_SOC_TEGRA_WM8903
	if SND_SOC
In-Reply-To: <20110727153144.GU16561@pengutronix.de>
References: <74CDBE0F657A3D45AFBB94109FB122FF049EBDF52B@HQMAIL01.nvidia.com>
	<201107271711.05040.arnd@arndb.de>
	<20110727153144.GU16561@pengutronix.de>
Message-ID: <201107271833.57993.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 July 2011, Uwe Kleine-K?nig wrote:
> On Wed, Jul 27, 2011 at 05:11:04PM +0200, Arnd Bergmann wrote:
> > Applied to 'fixes' branch, thanks everyone!
> Would you care to take the other patch in this series, too?
> (http://thread.gmane.org/gmane.linux.ports.tegra/1138/focus=1139)

That does not look like a bug fix to me. I don't mind the patch,
but I see no reason to apply it at this point, or to the 'fixes'
branch.

I'll wait for Colin to accumulate more patches and then pull those
from him into a tegra specific branch for 3.2, ok? If Colin wants
to have it 3.1, I can pull it into the fixes branch after -rc1.

	Arnd
