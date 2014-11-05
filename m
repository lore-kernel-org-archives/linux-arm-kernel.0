From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Nov 2014 10:45:43 +0100
Subject: [linux-sunxi] [PATCH 3/6] phy: Add driver to support individual
 USB PHYs on sun9i
In-Reply-To: <1415081773.665.1.camel@plaes.org>
References: <1415074039-16590-1-git-send-email-wens@csie.org>
 <1415074039-16590-4-git-send-email-wens@csie.org>
 <1415081773.665.1.camel@plaes.org>
Message-ID: <20141105094543.GC27686@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 08:16:13AM +0200, Priit Laes wrote:
> > --- a/drivers/phy/Kconfig
> > +++ b/drivers/phy/Kconfig
> > @@ -153,6 +153,18 @@ config PHY_SUN4I_USB
> >                         This driver controls the entire USB PHY 
> > block, both the USB OTG
> >                         parts, as well as the 2 regular USB 2 host 
> > PHYs.
> > 
> > +config PHY_SUN9I_USB
> > +       tristate "Allwinner sun9i SoC USB PHY driver"
> 
> Adding 'A80' to the user visible data makes things a bit easier for 
> end users:
> "AllWinner sun9i (A80) SoC USB PHY driver"

Until some new SoC part of the sun9i family comes up, and it will just
add to the confusion.

Plus, who the "end user" is for a Kconfig file? My guess is that it is
a kernel developper, or at least someone with a good kernel
experience.

Such a person would know that the A80 is part of the sun9i family if
it has some knowledge of the Allwinner SocS. And if they don't, A80 or
sun9i or both won't make any kind of difference.

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/97e24603/attachment.sig>
