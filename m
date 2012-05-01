From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 1 May 2012 08:54:54 +0000
Subject: [GIT PULL] ARM: SPEAr13xx support for 3.5
In-Reply-To: <20120501084236.GX24211@n2100.arm.linux.org.uk>
References: <CAOh2x==Dh5thHoQaQ+eN34oeWsmZ32kMOOQ6nU5kO7Tfcr=PUA@mail.gmail.com>
 <20120501083813.GW24211@n2100.arm.linux.org.uk>
 <20120501084236.GX24211@n2100.arm.linux.org.uk>
Message-ID: <201205010854.54911.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 May 2012, Russell King - ARM Linux wrote:
> On Tue, May 01, 2012 at 09:38:13AM +0100, Russell King - ARM Linux wrote:
> > On Tue, May 01, 2012 at 08:34:14AM +0000, Arnd Bergmann wrote:
> > > On Tuesday 01 May 2012, Viresh Kumar wrote:
> > > > - Russell's: CLKDEV: Add helper routines to allocate and add clkdevs for ... 
> > > 
> > > I could not find out the status of that patch. Which branch is it going to get
> > > merged through?
> > 
> > That's because I've not committed it yet.
> 
> Note also that the latest version of it, posted just last Saturday, has
> yet to attract any replies what so ever.

Ok. In that case, we need to wait until that is settled and applied to a
stable branch. Viresh, please tell me when all the dependencies are merged
somewhere, then we can do a refresh of your patches on top of those. You can
either send me a new version then, or I can rebased the patches from the
staging branch and apply them into a proper next/* branch.

	Arnd
