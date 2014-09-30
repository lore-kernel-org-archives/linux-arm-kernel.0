From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Sep 2014 10:03:54 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140930053900.GD29874@ulmo>
References: <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140929165842.GC5599@skynet.be>
 <20140929220250.GD5599@skynet.be> <20140930053900.GD29874@ulmo>
Message-ID: <20140930080354.GI4081@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 07:39:02AM +0200, Thierry Reding wrote:
> You keep bringing up the Raspberry Pi for some reason and suggest that
> it is somehow inferior to sunxi. What makes you think it's less entitled
> to be supported on Linux than sunxi? I don't care about the Raspberry Pi
> and I equally don't care about sunxi. I don't own a Raspberry Pi and I
> don't own any Allwinner hardware. What I do care about is Linux and I
> want it to work well for all SoCs equally.
> 
> Perhaps if you could put aside your crusade against the Raspberry Pi for
> just a second you'll realize that we're all on the same team. This isn't
> a competition and I'm not trying to put a spoke in your wheel. On the
> contrary, I'm actually trying to help you.

We've been over this already, and I'll tell you again that you're
getting this wrong.

No platform is more entitled to get merged than another one. I do care
about the Allwinner SoCs, and I care just as much about the broader
Linux support for all the other SoCs, be it from nvidia, samsung or
whatever vendor you can come up with.

But you can't hide the fact that the bcm2835 still has a very limited
clock support, and I really don't know about its clock tree, but I
guess that if the times come when they add a more complete clock
support, they will face the same issue.

If the driver would have been developped initially to create a
framebuffer on the Allwinner SoCs, at a time when we didn't have any
clock support too, calling it only usable on sunxi wouldn't have
shocked me tbh.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/302037e7/attachment.sig>
