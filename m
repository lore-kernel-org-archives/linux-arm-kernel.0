From: sre@ring0.de (Sebastian Reichel)
Date: Sun, 22 Sep 2013 16:24:56 +0200
Subject: [PATCH v2 0/9] wilink: add device tree support
In-Reply-To: <20130922133632.GB8643@amd.pavel.ucw.cz>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <CANOLnOPBHesTiV61zpQ_QS9c7E91K50EnbMnGhvgaViuA_3=Bw@mail.gmail.com>
 <1372859132.21065.111.camel@cumari.coelho.fi>
 <20130921122718.GA4431@amd.pavel.ucw.cz>
 <20130921141614.GA21383@earth.universe>
 <20130922133632.GB8643@amd.pavel.ucw.cz>
Message-ID: <20130922142455.GA31967@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 22, 2013 at 03:36:32PM +0200, Pavel Machek wrote:
> > > > Unfortunately I don't have much time to work on wl1251.  I think it
> > > > wouldn't be too difficult to do though, so patches are welcome. ;)
> > > > 
> > > > Maybe you could try to make this change and I could support you if
> > > > needed?
> > > > 
> > > > 
> > > > > I can offer you my help testing things on pandora and I'm sure someone
> > > > > here could try it on N900.
> > > > 
> > > > I could try it on the N900, if it is still bootable easily with the
> > > > mainline. ;)
> > > 
> > > 3.11 should be bootable on mainline, including device tree and
> > > video. (But excluding some other stuff, like MMC.)
> > 
> > I got external MMC (=> ?SD) working with some small modifications of
> > the omap3-n900.dts file. I have not yet tried internal MMC, since
> > its not important for me at the moment, but I guess its also just a
> > small change in the dts file.
> 
> Can we get the diff? :-).

I will sent a patchset for the omap3-n900.dts file in the next days.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130922/f19b75aa/attachment.sig>
