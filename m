From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 15 Sep 2015 12:53:54 -0400
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150915163642.GW21084@n2100.arm.linux.org.uk>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
 <m3bnd52y4s.fsf@t19.piap.pl> <1442332425.2637.16.camel@pengutronix.de>
 <20150915163642.GW21084@n2100.arm.linux.org.uk>
Message-ID: <1442336034.2637.20.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Dienstag, den 15.09.2015, 17:36 +0100 schrieb Russell King - ARM
Linux:
> On Tue, Sep 15, 2015 at 05:53:45PM +0200, Lucas Stach wrote:
> > It includes a new kernel<->userspace interface, so needs a modified
> > xf86-video-armada to go with it. You can pick that up here:
> > git://git.pengutronix.de/git/lst/xf86-video-armada.git for-rmk
> > 
> > Caution: the armada code is WIP and needs further cleanups. It
> > should
> > work though.
> 
> And it needs updating to the latest version - you seem to be missing
> a whole load of changes, including the changes which update the
> kernel API.
> 
> So... you seem to be talking about the kernel API having changed from
> the version which you picked up years ago, rather than the current
> version.  It's really unclear what you're talking about.
> 
What do you mean with missing a lot of stuff? The "for-rmk" branch in
that repo is your upstream "unstable-devel" branch minus the few XvBO
commits with my changes on top.

Regards,
Lucas
