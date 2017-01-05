From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 5 Jan 2017 22:19:47 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <3286019.I2UkVCJq41@wuerfel>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
 <20170103152436.GA26156@kroah.com> <3286019.I2UkVCJq41@wuerfel>
Message-ID: <20170105211947.GA18143@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 10:19:29PM +0100, Arnd Bergmann wrote:
> On Tuesday, January 3, 2017 4:24:36 PM CET Greg Kroah-Hartman wrote:
> > On Wed, Mar 02, 2016 at 08:06:46PM +0100, Arnd Bergmann wrote:
> > > The icn, act2000 and pcbit drivers are all for very old hardware,
> > > and it is highly unlikely that anyone is actually still using them
> > > on modern kernels, if at all.
> > > 
> > > All three drivers apparently are for hardware that predates PCI
> > > being the common connector, as they are ISA-only and active
> > > PCI ISDN cards were widely available in the 1990s.
> > > 
> > > Looking through the git logs, it I cannot find any indication of a
> > > patch to any of these drivers that has been tested on real hardware,
> > > only cleanups or global API changes.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Karsten Keil <isdn@linux-pingi.de>
> > 
> > This patch got added in the 4.6 kernel release.  As I am now taking
> > patches for 4.11-rc1, I figure it is time to just delete the
> > drivers/staging/i4l/ directory now, given that no one has really done
> > anything with it.  If people show up that wish to maintain it, I'll be
> > glad to revert it, or if someone really screams in the next week.
> > Otherwise it's time to just move on 
> 
> Sounds good to me.

Ok, now deleted!

thanks,

greg k-h
