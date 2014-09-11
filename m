From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Sep 2014 21:02:55 +0200
Subject: [PATCH] ARM: sunxi: Remove sun4i reboot code from mach directory
In-Reply-To: <20140911175426.GA32184@lukather>
References: <1409332787-23923-1-git-send-email-maxime.ripard@free-electrons.com>
 <201409052215.30171.arnd@arndb.de> <20140911175426.GA32184@lukather>
Message-ID: <3194253.M0WqeHViJW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014 19:54:26 Maxime Ripard wrote:
> On Fri, Sep 05, 2014 at 10:15:29PM +0200, Arnd Bergmann wrote:
> > On Friday 05 September 2014, Kevin Hilman wrote:
> > > Maxime Ripard <maxime.ripard@free-electrons.com> writes:
> > > 
> > > > Now that the restart code has been merged in the watchdog driver, we don't need
> > > > the restart code in the mach-sunxi directory anymore.
> > > >
> > > > Remove it entirely.
> > > >
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > ---
> > > >
> > > > Hi Arnd, Kevin, Olof,
> > > >
> > > > I don't know if this can be considered 3.17 material, but if so, it would be
> > > > great if you could merge it directly.
> > > 
> > > I don't think it's v3.17 material at this point in the cycle because
> > > it's not a regression fix.
> > > 
> > > Please add it to your queue for v3.18.
> > 
> > I agree. I had actually put it into my apply-for-3.18 queue already, but
> > it's better if this comes through the normal cleanups from Maxime, unless
> > he has nothing else yet and prefers me to apply it to the next/cleanup
> > branch now.
> 
> If possible, yes. I have no other cleanups queued up so far.

Ok, applied to next/cleanup now.

	Arnd
