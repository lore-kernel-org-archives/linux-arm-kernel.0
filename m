From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 7 Jan 2011 13:45:58 -0800
Subject: [PATCH] ARM: aaec2000: remove support for mach-aaec2000
In-Reply-To: <20110107213303.GJ2844@pulham.picochip.com>
References: <1294430422-939-1-git-send-email-jamie@jamieiles.com>
	<0D753D10438DA54287A00B027084269764C4123E68@AUSP01VMBX24.collaborationhost.net>
	<20110107213303.GJ2844@pulham.picochip.com>
Message-ID: <20110107214558.GE28875@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 07, 2011 at 09:33:03PM +0000, Jamie Iles wrote:
> On Fri, Jan 07, 2011 at 02:49:25PM -0600, H Hartley Sweeten wrote:
> > On Friday, January 07, 2011 1:00 PM, Jamie Iles wrote:
> > >
> > > mach-aaec2000 is no longer actively maintained and is only receiving
> > > fixups to remain building with other kernel updates.
> > 
> > What about the MACH_AAED2000 specific drivers?  The only one I see is:
> > 
> > drivers/input/keyboard/aaed2000_kbd.c
> 
> Hi Hartley,
> 
> Yes, you're quite right.  I was grepping for AAEC2000 and missed this 
> one.
> 
> Russell, given your post earlier about the ARM pull last night, should 
> this removal go through the input tree?
> 

I'll take it.

Thanks.
-- 
Dmitry
