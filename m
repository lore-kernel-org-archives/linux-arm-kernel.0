From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 24 May 2014 17:09:41 +0200
Subject: [PATCH RESEND v4 0/8] Add Allwinner A31 USB support
In-Reply-To: <20140523221940.GB18106@kroah.com>
References: <20140514160520.GA4679@kroah.com> <20140523183339.GC10768@lukather>
 <20140523221940.GB18106@kroah.com>
Message-ID: <20140524150941.GG10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 24, 2014 at 07:19:40AM +0900, Greg Kroah-Hartman wrote:
> On Fri, May 23, 2014 at 08:33:39PM +0200, Maxime Ripard wrote:
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
> > It looks like it's still not in your tree (or at least, I haven't
> > received the usual mail notifications).
> > 
> > Is this expected?
> 
> Given that I haven't applied any USB patches in a week or so, yes, it is
> expected...
> 
> Give me a week or so to catch up, I've been on the road for a month
> now, and am finally home.

Ok, thanks, I was just trying to make sure they weren't
lost/forgotten.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140524/dcafa87f/attachment.sig>
