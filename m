From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 25 Apr 2014 16:22:51 +0200
Subject: [PATCH 000/222] The *Full* Cubox-i series
In-Reply-To: <20140425141550.GQ26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
 <20140425135048.GA7388@ulmo>
 <20140425141550.GQ26756@n2100.arm.linux.org.uk>
Message-ID: <20140425142250.GA6091@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 03:15:50PM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 25, 2014 at 03:50:49PM +0200, Thierry Reding wrote:
> > On Fri, Apr 25, 2014 at 12:29:51PM +0100, Russell King - ARM Linux wrote:
> > > So that people can see what kind of a patch nightmare I'm in, and
> > > hopefully start being more co-operative towards getting patches into
> > > mainline, here is the *full* patch set for CuBox-i support that I'm
> > > presently sitting on.
> > > 
> > > Anything that can be done to make this easier would be very helpful,
> > > so I'm not spending lots of time tweaking some random patch and then
> > > having to remerge all these different sub-series.
> > 
> > Do you happen to have a branch that I can pull to test this on Tegra? Is
> > there anything that I should be paying special attention to when
> > testing?
[...]
> What I would like to do is to get some of these patches into a "finished"
> state (iow, reviewed and tested) and properly queued up for the next merge
> window so I don't have to mess around with soo many in-flux patches, as
> I have been for the last two to three months.

Okay. I don't have access to a whole lot of hardware myself. It's really
just a couple of Tegra boards, but I can still at least run the patches
and report back if (or not) there's any breakage and help debug from
there.

But I'm somewhat reluctant to go pick up 222 patches from my inbox
manually if there's a branch available somewhere that I can pick up more
easily.

> At the moment, the rate at which I seem to be able to get patches into
> the mainline kernel is down around 40 per cycle (basically the imx-drm
> debacle), which is piss poor when dealing with such a big backlog - a
> backlog which has taken just four months to build up.

I've been through some of that same myself. Hence my offer to help.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/aadfc6da/attachment.sig>
