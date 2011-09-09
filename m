From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Sep 2011 09:11:52 -0700
Subject: [PATCH v2] ASoC: omap: convert per-board modules to platform
	drivers
In-Reply-To: <20110909094156.GE6918@n2100.arm.linux.org.uk>
References: <1315503297-8365-1-git-send-email-mans.rullgard@linaro.org>
	<CABb+yY0b607kDSGU+trycqQuvGMhC-zpHcv20wjgmEcaK7dz8Q@mail.gmail.com>
	<CAG5Tg6UOuztenNid1=YbH9a4ZH5MqV4YhohG+r9R+7F=zXs=CQ@mail.gmail.com>
	<3110288.bQbb0H2ME1@wuerfel>
	<1315520956.4126.3.camel@finisterre.wolfsonmicro.main>
	<20110908223720.GA21469@n2100.arm.linux.org.uk>
	<20110908224731.GB5201@opensource.wolfsonmicro.com>
	<20110908230102.GB21469@n2100.arm.linux.org.uk>
	<20110908235903.GA6370@opensource.wolfsonmicro.com>
	<20110909094156.GE6918@n2100.arm.linux.org.uk>
Message-ID: <20110909161151.GA3515@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2011 at 10:41:56AM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 08, 2011 at 04:59:04PM -0700, Mark Brown wrote:

> > The problem is that someone has to manually go and add the device to
> > every board that needs one and people find that tedious and slightly
> > inelegant

> Sheesh.  So now you're arguing against your statement above?  Please
> stop wasting my time.

There's two things going on here - what we are doing and what people
would like to be able to do.  What we are doing is explicitly adding
devices, what people would like to do is infer the devices from the
board type.  Personally I'm totally happy with explicitly adding an
audio device, but not everyone is and I do understand where they're
coming from.
