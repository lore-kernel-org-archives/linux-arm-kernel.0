From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 May 2012 13:41:47 +0000
Subject: linux-next: manual merge of the arm-soc tree with the staging tree
In-Reply-To: <20120516131021.GA32351@kroah.com>
References: <20120516185812.ce1ab57c3ec72445135a35fc@canb.auug.org.au>
 <201205161303.35080.arnd@arndb.de> <20120516131021.GA32351@kroah.com>
Message-ID: <201205161341.47440.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 May 2012, Greg KH wrote:
> On Wed, May 16, 2012 at 01:03:34PM +0000, Arnd Bergmann wrote:
> > The staging tree version adds contents to at91sam9g20.dtsi, and the context
> > gets moved to at91sam9260.dtsi in arm-soc. If we want to resolve it now,
> > I think the best way is to add the change to at91sam9260.dtsi in arm-soc
> > and let you drop that part in staging. There are no hard dependencies
> > since this is new code and it the driver is still correct without the
> > change, it simply won't find the device.
> 
> Ok, so if we leave it as-is for now, we can resolve it after 3.5-rc1 is
> out and we see what branch ended up "winning"?  :)

Yes, works for me.

	Arnd
