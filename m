From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 9 Aug 2012 11:53:50 +0100
Subject: [PATCH v2 3/4] regulator: add a new API
 regulator_set_voltage_tol()
In-Reply-To: <20120808143004.GB14718@S2101-09.ap.freescale.net>
References: <1344179121-17738-1-git-send-email-shawn.guo@linaro.org>
 <1344179121-17738-4-git-send-email-shawn.guo@linaro.org>
 <20120808133540.GB16861@opensource.wolfsonmicro.com>
 <20120808143004.GB14718@S2101-09.ap.freescale.net>
Message-ID: <20120809105349.GL24328@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 10:30:07PM +0800, Shawn Guo wrote:
> On Wed, Aug 08, 2012 at 02:35:40PM +0100, Mark Brown wrote:

> > Applied, thanks!  It's on a separate branch so can easily be either
> > applied somewhere else or merged into another tree if required for
> > dependencies, just let me know.

> I intended to have the whole series go via cpufreq tree with your ack
> on this patch.  But I could also ask Rafael to merge your branch to
> resolve the dependency.

I anticipate wanting the new API in other trees too (I have one likely
use in mind) so having it only in the cpufreq tree would be inconvenient.
The whole reason to have this in the regulator API is that it's
something that's useful outside your cpufreq code!
