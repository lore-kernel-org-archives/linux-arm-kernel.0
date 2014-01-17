From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 18:04:29 +0100
Subject: [PATCH v3 7/7] ARM: brcmstb: dts: add a reference DTS for
 Broadcom 7445
In-Reply-To: <20140116134732.GB17314@sirena.org.uk>
References: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
 <201401161219.01038.arnd@arndb.de> <20140116134732.GB17314@sirena.org.uk>
Message-ID: <201401171804.30572.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 January 2014, Mark Brown wrote:
> On Thu, Jan 16, 2014 at 12:19:00PM +0100, Arnd Bergmann wrote:
> 
> > 1. Other platforms also require the syscon driver to be active before
> > the regular device driver probing starts. Michal Simek has the same
> > issue in the zynq clock driver that you have for SMP initialization.
> > We have talked about this with Mark Brown already, and I think we will
> > find a solution for this in the end, but it's not as straightforward
> > as I first hoped. We can probably use help in this area.
> 
> I thought the solution with deferring registration of the resource for
> dev_get_regmap() until a proper device materialised seemed simple and
> enough, did you folks run into any problems with that?  I had assumed a
> patch was likely to materialise so wasn't worrying about it myself.

I'm still hoping that Michal will do that patch.

	Arnd
