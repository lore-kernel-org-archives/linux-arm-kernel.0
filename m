From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Sep 2011 12:30:11 -0700
Subject: [PATCH v2] ASoC: omap: convert per-board modules to platform
	drivers
In-Reply-To: <20110909190134.GA14520@n2100.arm.linux.org.uk>
References: <CAG5Tg6UOuztenNid1=YbH9a4ZH5MqV4YhohG+r9R+7F=zXs=CQ@mail.gmail.com>
	<3110288.bQbb0H2ME1@wuerfel>
	<1315520956.4126.3.camel@finisterre.wolfsonmicro.main>
	<20110908223720.GA21469@n2100.arm.linux.org.uk>
	<20110908224731.GB5201@opensource.wolfsonmicro.com>
	<20110908230102.GB21469@n2100.arm.linux.org.uk>
	<20110908235903.GA6370@opensource.wolfsonmicro.com>
	<20110909094156.GE6918@n2100.arm.linux.org.uk>
	<20110909161151.GA3515@opensource.wolfsonmicro.com>
	<20110909190134.GA14520@n2100.arm.linux.org.uk>
Message-ID: <20110909193010.GA2993@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 08:01:35PM +0100, Russell King - ARM Linux wrote:

> Well, with DT, there won't be any 'board type' anymore.  There won't be
> any 'machine_is_xxx()' to sort it out anymore.  Using DT, all that will
> be history - it's all got to be sorted out by either devices or device
> properties.

There is a board type - there's a root compatible property for the board
which fulfils this purpose - so the situation with and without device
tree is essentially the same.
