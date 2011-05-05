From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 May 2011 14:59:02 +0100
Subject: Common clock and dvfs
In-Reply-To: <BANLkTimfN-1J8LifEzsnJ-GFfp0GXGDm+A@mail.gmail.com>
References: <4DC07F10.6010305@ti.com> <4DC230E0.7090909@ti.com>
	<BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
	<alpine.DEB.2.00.1105050026420.30136@utopia.booyaka.com>
	<BANLkTimfN-1J8LifEzsnJ-GFfp0GXGDm+A@mail.gmail.com>
Message-ID: <20110505135901.GA26651@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2011 at 11:50:52PM -0700, Colin Cross wrote:

> True, that was an oversimplificaiton. I meant the minimum voltage that
> scales with clock frequencies only depends on the clock frequency, not
> the device.  Devices do need to be able to specify a higher minimum
> voltage, and the regulator api needs to handle it.

The regulator API already supports this so we're fine there.
