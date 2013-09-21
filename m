From: sre@ring0.de (Sebastian Reichel)
Date: Sat, 21 Sep 2013 16:16:16 +0200
Subject: [PATCH v2 0/9] wilink: add device tree support
In-Reply-To: <20130921122718.GA4431@amd.pavel.ucw.cz>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <CANOLnOPBHesTiV61zpQ_QS9c7E91K50EnbMnGhvgaViuA_3=Bw@mail.gmail.com>
 <1372859132.21065.111.camel@cumari.coelho.fi>
 <20130921122718.GA4431@amd.pavel.ucw.cz>
Message-ID: <20130921141614.GA21383@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 21, 2013 at 02:27:18PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > This is a follow-up on a previous patch set that had a smaller
> > > > audience.  This time, I added the lists and people who were involved
> > > > in the review of the bindings documentation, since most of my changes
> > > > in v2 are coming from discussions there.
> > > >
> > > > This patch series adds device tree support to the wlcore_sdio driver,
> > > > which is used by WiLink6, WiLink7 and WiLink8.
> > > 
> > > Could you perhaps consider doing device tree conversion for wl1251
> > > too? With the knowledge you have from working on this series, it would
> > > be much easier for you to do it than for someone else, and I don't
> > > have much hope someone will do it at all. It's WiLink series chip
> > > after all. Without this pandora and N900 are going to lose wifi
> > > support after the switch to dt-only kernel.
> > 
> > Unfortunately I don't have much time to work on wl1251.  I think it
> > wouldn't be too difficult to do though, so patches are welcome. ;)
> > 
> > Maybe you could try to make this change and I could support you if
> > needed?
> > 
> > 
> > > I can offer you my help testing things on pandora and I'm sure someone
> > > here could try it on N900.
> > 
> > I could try it on the N900, if it is still bootable easily with the
> > mainline. ;)
> 
> 3.11 should be bootable on mainline, including device tree and
> video. (But excluding some other stuff, like MMC.)

I got external MMC (=> ?SD) working with some small modifications of
the omap3-n900.dts file. I have not yet tried internal MMC, since
its not important for me at the moment, but I guess its also just a
small change in the dts file.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130921/a6c98946/attachment.sig>
