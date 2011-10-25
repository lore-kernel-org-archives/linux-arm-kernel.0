From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 25 Oct 2011 09:11:40 +0200
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111024144716.GG1755@S2100-06.ap.freescale.net>
References: <4E9FAF42.5060200@ti.com>
	<20111020061408.GE32007@S2100-06.ap.freescale.net>
	<4EA00F7C.1080005@ti.com>
	<20111021082309.GA337@S2100-06.ap.freescale.net>
	<20111024092411.GE8708@ponder.secretlab.ca>
	<20111024130429.GD1755@S2100-06.ap.freescale.net>
	<20111024130636.GB26033@opensource.wolfsonmicro.com>
	<20111024134025.GE1755@S2100-06.ap.freescale.net>
	<20111024134930.GD26033@opensource.wolfsonmicro.com>
	<20111024144716.GG1755@S2100-06.ap.freescale.net>
Message-ID: <20111025071140.GC2919@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 10:47:17PM +0800, Shawn Guo wrote:
> On Mon, Oct 24, 2011 at 03:49:30PM +0200, Mark Brown wrote:

> > Might be best to just
> > search within dev and get drivers to pass the "real" device in when
> > registering the regulator rather than the virtual device.

> It should also work, but it will also change the API slightly for
> non-dt users.  I'm not sure it's something we want.

I don't think that's an issue at all.
