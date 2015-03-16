From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 19:59:04 +0000
Subject: [PATCH v2 0/2] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <20150316181023.GT5264@atomide.com>
References: <201502271645.58765@pali>
 <1425052528-18995-1-git-send-email-pali.rohar@gmail.com>
 <20150302112836.GA27317@amd> <20150316154409.GQ5264@atomide.com>
 <20150316161449.GJ8656@n2100.arm.linux.org.uk>
 <20150316181023.GT5264@atomide.com>
Message-ID: <20150316195904.GN8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 11:10:26AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [150316 09:15]:
> > On Mon, Mar 16, 2015 at 08:44:10AM -0700, Tony Lindgren wrote:
> > > * Pavel Machek <pavel@ucw.cz> [150302 03:32]:
> > > > On Fri 2015-02-27 16:55:26, Pali Roh?r wrote:
> > > > > This patch adds support for DT "/revision" and convert ATAG_REVISION to DT.
> > > > > 
> > > > > Pali Roh?r (2):
> > > > >   arm: devtree: Set system_rev from DT revision
> > > > >   arm: boot: convert ATAG_REVISION to DT revision field
> > > > 
> > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > Are these queued somewhere now? Sounds like this is the last pending
> > > issue for n900 to use legacy user space with current mainline kernels,
> > > so I'd like to get these in so we can get closer to making omap3 boot
> > > in device tree only mode.
> > 
> > Not that I know of.  As everyone is aware, patches need to be in my
> > patch system if they want me to apply them - which would've been
> > especially important as I was away from kernel stuff for a week at
> > the start of March (for medical reasons) and I can't be expected to
> > track the status of stuff which is buried behind 1000+ extra mails.
> 
> Pali, care to upload these two patches to Russell's patch tracking
> system if no other comments?

If it's done soon, I should be able to send them to Linus fairly quickly,
since this problem I'm grappling with is being seen by others who have
better tools to be able to investigate the problem (and hence they're in
a better position to investigate what's going on.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
