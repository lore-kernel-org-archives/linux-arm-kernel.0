From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 05 Dec 2014 10:44:29 +0100
Subject: [GIT PULL] Reset controller changes for v3.19
In-Reply-To: <22096876.byu7bonZ1i@wuerfel>
References: <1417424646.4624.2.camel@pengutronix.de>
 <1417426996.4624.4.camel@pengutronix.de> <22096876.byu7bonZ1i@wuerfel>
Message-ID: <1417772669.3227.4.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 04.12.2014, 17:00 +0100 schrieb Arnd Bergmann:
> On Monday 01 December 2014 10:43:16 Philipp Zabel wrote:
> > Am Montag, den 01.12.2014, 10:04 +0100 schrieb Philipp Zabel:
> > > Hi Arnd, Olof,
> > > 
> > > The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> > > 
> > >   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.pengutronix.de/pza/linux.git reset-for-3.19-2
> > 
> > Sorry, that should be
> > 
> >    git://git.pengutronix.de/git/pza/linux.git reset-for-3.19-2
> >                             ^^^^
> > 
> 
> 
> Sorry for not seeing this first, my mistake.
> 
> Pulled into next/drivers now.
> 
> One detail though: in the future please add a high-level description
> of the branch contents when you send a pull request. This is what
> I added:
> 
>     This adds a new driver for the sti soc family, and creates
>     a reset_control_status interface, which is added to the existing
>     drivers.
>     
> but I would normally expect a higher detail level.

Thank you, I will have a better description next time.

regards
Philipp
