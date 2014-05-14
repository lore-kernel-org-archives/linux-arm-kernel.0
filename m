From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 14 May 2014 18:05:20 +0200
Subject: [PATCH RESEND v4 0/8] Add Allwinner A31 USB support
In-Reply-To: <20140514123419.GK29258@lukather>
References: <1399995862-17788-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140514123419.GK29258@lukather>
Message-ID: <20140514160520.GA4679@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 02:34:19PM +0200, Maxime Ripard wrote:
> On Tue, May 13, 2014 at 05:44:14PM +0200, Maxime Ripard wrote:
> > Hi everyone,
> > 
> > This patchset adds support for the USB controllers found in the
> > Allwinner A31.
> > 
> > While the design is similar to the earlier Allwinner SoCs that are
> > already supported, a few details here and there change, like the fact
> > that the PHYs now have one clock per phy, while it used to be only one
> > for all the PHYs.
> > 
> > Resent adding Alan Stern's Acked-by and puting Greg KH in the
> > recipients this time...
> 
> Applied patches 2, 7 and 8.

Feel free to apply patches 5 and 6 to your tree, as your branch needs
these, with my:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Or, if you want me to take them, just let me know and I will.

thanks,

greg k-h
