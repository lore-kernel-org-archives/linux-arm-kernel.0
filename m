From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 00:18:45 +0200
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
In-Reply-To: <20160425115758.GA4874@lukather>
References: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
 <20160425115758.GA4874@lukather>
Message-ID: <8373519.0RWpCDubQ0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 April 2016 13:57:58 Maxime Ripard wrote:
> Hi,
> 
> On Sat, Apr 23, 2016 at 11:43:58AM +0200, Linus Walleij wrote:
> > Hi ARM SoC guys,
> > 
> > these two patches move the ARM character LCD driver from
> > misc drivers to the auxdisplay subsystem where it belongs and
> > updates the defconfig for the RealView accordingly.
> > 
> > Please pull it into some cleanup branch in the ARM SoC
> > tree.
> > 
> > I tried to get some ACK from the auxdisplay maintainer but no
> > reaction.
> 
> Auxdisplay is not a new framework, but rather a very old one.
> 
> It got introduced in 2.6.21, and only received a couple of drivers
> since.
> 
> It seems to be quite redundant with fbdev deferred_io, which itself is
> almost deprecated these days.

I'm holding off on this pull request for now then.

I'd certainly like to see the driver get moved out of drivers/misc,
let me know once there has been an agreement of where it should go.

	Arnd
