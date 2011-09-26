From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Sep 2011 16:26:34 +0100
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110926151210.GO22455@n2100.arm.linux.org.uk>
References: <20110922184614.25419.84606.stgit@ponder>
	<20110926141643.GK2946@opensource.wolfsonmicro.com>
	<20110926151210.GO22455@n2100.arm.linux.org.uk>
Message-ID: <20110926152634.GN2946@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 04:12:10PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 26, 2011 at 03:16:43PM +0100, Mark Brown wrote:

> > used but it's not a blocker for anything.  Devices doing this would need
> > some way to figure out if they should -EBUSY or fail otherwise.

> Just to avoid confusion - ITYM -EAGAIN there.  -EBUSY is already used
> by drivers to mean "someone else claimed a resource I need" be it the
> IO region or an IRQ resource...

Yes, I do - sorry.
