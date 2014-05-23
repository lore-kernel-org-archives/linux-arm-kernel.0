From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 24 May 2014 07:19:40 +0900
Subject: [PATCH RESEND v4 0/8] Add Allwinner A31 USB support
In-Reply-To: <20140523183339.GC10768@lukather>
References: <20140514160520.GA4679@kroah.com> <20140523183339.GC10768@lukather>
Message-ID: <20140523221940.GB18106@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 08:33:39PM +0200, Maxime Ripard wrote:
> Hi Greg,
> 
> On Wed, May 14, 2014 at 06:05:20PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, May 14, 2014 at 02:34:19PM +0200, Maxime Ripard wrote:
> > > On Tue, May 13, 2014 at 05:44:14PM +0200, Maxime Ripard wrote:
> > > > Hi everyone,
> > > > 
> > > > This patchset adds support for the USB controllers found in the
> > > > Allwinner A31.
> > > > 
> > > > While the design is similar to the earlier Allwinner SoCs that are
> > > > already supported, a few details here and there change, like the fact
> > > > that the PHYs now have one clock per phy, while it used to be only one
> > > > for all the PHYs.
> > > > 
> > > > Resent adding Alan Stern's Acked-by and puting Greg KH in the
> > > > recipients this time...
> > > 
> > > Applied patches 2, 7 and 8.
> > 
> > Feel free to apply patches 5 and 6 to your tree, as your branch needs
> > these, with my:
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Or, if you want me to take them, just let me know and I will.
> 
> It looks like it's still not in your tree (or at least, I haven't
> received the usual mail notifications).
> 
> Is this expected?

Given that I haven't applied any USB patches in a week or so, yes, it is
expected...

Give me a week or so to catch up, I've been on the road for a month
now, and am finally home.

greg k-h
