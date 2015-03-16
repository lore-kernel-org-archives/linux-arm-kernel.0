From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 13:59:57 -0700
Subject: [PATCH v2 0/2] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <201503162154.27450@pali>
References: <201502271645.58765@pali> <20150316181023.GT5264@atomide.com>
 <20150316195904.GN8656@n2100.arm.linux.org.uk>
 <201503162154.27450@pali>
Message-ID: <20150316205956.GE12397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [150316 13:54]:
> On Monday 16 March 2015 20:59:04 Russell King - ARM Linux wrote:
> > On Mon, Mar 16, 2015 at 11:10:26AM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [150316
> > > 09:15]:
> > > > On Mon, Mar 16, 2015 at 08:44:10AM -0700, Tony Lindgren
> > > > wrote:
> > > > > * Pavel Machek <pavel@ucw.cz> [150302 03:32]:
> > > > > > On Fri 2015-02-27 16:55:26, Pali Roh?r wrote:
> > > > > > > This patch adds support for DT "/revision" and
> > > > > > > convert ATAG_REVISION to DT.
> > > > > > > 
> > > > > > > Pali Roh?r (2):
> > > > > > >   arm: devtree: Set system_rev from DT revision
> > > > > > >   arm: boot: convert ATAG_REVISION to DT revision
> > > > > > >   field
> > > > > > 
> > > > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > > > 
> > > > > Are these queued somewhere now? Sounds like this is the
> > > > > last pending issue for n900 to use legacy user space
> > > > > with current mainline kernels, so I'd like to get these
> > > > > in so we can get closer to making omap3 boot in device
> > > > > tree only mode.
> > > > 
> > > > Not that I know of.  As everyone is aware, patches need to
> > > > be in my patch system if they want me to apply them -
> > > > which would've been especially important as I was away
> > > > from kernel stuff for a week at the start of March (for
> > > > medical reasons) and I can't be expected to track the
> > > > status of stuff which is buried behind 1000+ extra mails.
> > > 
> > > Pali, care to upload these two patches to Russell's patch
> > > tracking system if no other comments?
> > 
> > If it's done soon, I should be able to send them to Linus
> > fairly quickly, since this problem I'm grappling with is
> > being seen by others who have better tools to be able to
> > investigate the problem (and hence they're in a better
> > position to investigate what's going on.)
> 
> I have no idea how to upload those patches into tracking system. 
> Right now I do not have enough time for testing any patches...

Well it's pretty easy, all you have to do is upload them to:

http://www.arm.linux.org.uk/developer/patches/

There's an email interface it too.
 
> Tony, or somebody else, if you have free time, can you upload 
> (my) patches to that needed tracking system?

Eeek, I'm swamped too, probably best that you do it yourself
since they're your patches.

Regards,

Tony
