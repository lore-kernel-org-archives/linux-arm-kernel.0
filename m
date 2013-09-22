From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 22 Sep 2013 15:36:32 +0200
Subject: [PATCH v2 0/9] wilink: add device tree support
In-Reply-To: <20130921141614.GA21383@earth.universe>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <CANOLnOPBHesTiV61zpQ_QS9c7E91K50EnbMnGhvgaViuA_3=Bw@mail.gmail.com>
 <1372859132.21065.111.camel@cumari.coelho.fi>
 <20130921122718.GA4431@amd.pavel.ucw.cz>
 <20130921141614.GA21383@earth.universe>
Message-ID: <20130922133632.GB8643@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Unfortunately I don't have much time to work on wl1251.  I think it
> > > wouldn't be too difficult to do though, so patches are welcome. ;)
> > > 
> > > Maybe you could try to make this change and I could support you if
> > > needed?
> > > 
> > > 
> > > > I can offer you my help testing things on pandora and I'm sure someone
> > > > here could try it on N900.
> > > 
> > > I could try it on the N900, if it is still bootable easily with the
> > > mainline. ;)
> > 
> > 3.11 should be bootable on mainline, including device tree and
> > video. (But excluding some other stuff, like MMC.)
> 
> I got external MMC (=> ?SD) working with some small modifications of
> the omap3-n900.dts file. I have not yet tried internal MMC, since
> its not important for me at the moment, but I guess its also just a
> small change in the dts file.

Can we get the diff? :-).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
