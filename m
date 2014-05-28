From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 May 2014 09:47:12 +0200
Subject: [PATCH RESEND v4 0/8] Add Allwinner A31 USB support
In-Reply-To: <20140527225318.GA21602@kroah.com>
References: <1399995862-17788-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140514123419.GK29258@lukather> <20140514160520.GA4679@kroah.com>
 <20140515091438.GR29258@lukather>
 <20140527225318.GA21602@kroah.com>
Message-ID: <20140528074712.GM4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 03:53:18PM -0700, Greg Kroah-Hartman wrote:
> On Thu, May 15, 2014 at 11:14:38AM +0200, Maxime Ripard wrote:
> > Hi Greg,
> > 
> > On Wed, May 14, 2014 at 06:05:20PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, May 14, 2014 at 02:34:19PM +0200, Maxime Ripard wrote:
> > > > On Tue, May 13, 2014 at 05:44:14PM +0200, Maxime Ripard wrote:
> > > > > Hi everyone,
> > > > > 
> > > > > This patchset adds support for the USB controllers found in the
> > > > > Allwinner A31.
> > > > > 
> > > > > While the design is similar to the earlier Allwinner SoCs that are
> > > > > already supported, a few details here and there change, like the fact
> > > > > that the PHYs now have one clock per phy, while it used to be only one
> > > > > for all the PHYs.
> > > > > 
> > > > > Resent adding Alan Stern's Acked-by and puting Greg KH in the
> > > > > recipients this time...
> > > > 
> > > > Applied patches 2, 7 and 8.
> > > 
> > > Feel free to apply patches 5 and 6 to your tree, as your branch needs
> > > these, with my:
> > > 
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > Or, if you want me to take them, just let me know and I will.
> > 
> > You can merge them, I don't need them in any of my branch.
> 
> Now applied, thanks.

Great, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/73f9a6e6/attachment-0001.sig>
