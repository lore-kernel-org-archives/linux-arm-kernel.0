From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 30 Sep 2014 07:39:02 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140929220250.GD5599@skynet.be>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140929165842.GC5599@skynet.be>
 <20140929220250.GD5599@skynet.be>
Message-ID: <20140930053900.GD29874@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 12:02:50AM +0200, Luc Verhaegen wrote:
> On Mon, Sep 29, 2014 at 06:58:42PM +0200, Luc Verhaegen wrote:
> > 
> > In the 2nd round of this discussion, i stated that another fb or even a 
> > drm driver altogether seemed to be the sensible way out of this mess.
> > 
> > I suggest drm_rescue.
> > 
> > Very early on, now almost two months back, i used the word "denialfb".
> > rpifb is the real name of this thing though, but then the dt binding 
> > names would have to change and whatnot.
> > 
> > I don't get the resistance, at least not from a technical point of view. 
> > And i do not care enough to get properly involved in this pointless and 
> > endless discussion. drm_rescue it is.
> > 
> > Luc Verhaegen.
> 
> So Thierry, let's review what we have achieved here.
> 
> 1) you keep simplefb absolutely true to the name. Congratulations.
> 2) Simplefb will only have a single user: the rpi. As the only other 
> users i can think of, which does not have a full driver and which does 
> not have clocks automatically disabled, are discrete cards. And they do 
> not really tend to happen with dt or platform devices.
> 3) a competing driver will be created, which will do these dt-ishy 
> things.

You clearly haven't bothered to even try and understand what I wanted to
achieve. If you had you'd realize that creating a competing driver isn't
going to change anything.

> 4) it's just a matter of time before the rpi either gets a full driver, 
> or switches over to the driver that everyone else is actually using. And 
> then the misnomer gets deprecated.
> 
> Was that the outcome you were looking for? I think not.

I had, perhaps naively, expected that you guys would be willing to look
beyond your own nose. You clearly aren't. You've been outright
dismissing any proposals beyond what you originally posted.

You keep bringing up the Raspberry Pi for some reason and suggest that
it is somehow inferior to sunxi. What makes you think it's less entitled
to be supported on Linux than sunxi? I don't care about the Raspberry Pi
and I equally don't care about sunxi. I don't own a Raspberry Pi and I
don't own any Allwinner hardware. What I do care about is Linux and I
want it to work well for all SoCs equally.

Perhaps if you could put aside your crusade against the Raspberry Pi for
just a second you'll realize that we're all on the same team. This isn't
a competition and I'm not trying to put a spoke in your wheel. On the
contrary, I'm actually trying to help you.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/c2c88ef1/attachment.sig>
