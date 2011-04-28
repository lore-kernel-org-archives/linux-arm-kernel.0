From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Apr 2011 11:23:45 +0200
Subject: [PATCH v2 23/23] at91: Remove mAgic and ISI device code
In-Reply-To: <20110428091919.GQ17290@n2100.arm.linux.org.uk>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-24-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D242FC6C@AUSP01VMBX24.collaborationhost.net>
	<4DB08FC5.2@bluewatersys.com>
	<20110428091919.GQ17290@n2100.arm.linux.org.uk>
Message-ID: <20110428092345.GC3852@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:19 Thu 28 Apr     , Russell King - ARM Linux wrote:
> On Fri, Apr 22, 2011 at 08:12:53AM +1200, Ryan Mallon wrote:
> > On 22/04/11 05:33, H Hartley Sweeten wrote:
> > > On Wednesday, April 20, 2011 10:42 PM, Ryan Mallon wrote:
> > >>
> > >> The AT572D940HF mAgic device and the AT91SAM9263 ISI device do not
> > >> have drivers yet and therefore the platform code in arch/arm/mach-at91
> > >> is unused and can be removed.
> > > 
> > > Is anyone planning on adding these drivers?
> > > 
> > > I wonder if it makes sense to add the infrastructure to devices.[ch] and
> > > convert the users even it the drivers are not in mainline yet?
> > 
> > I removed them because there is currently a push to reduce the size of
> > the ARM tree. The ISI code has been there since 2008 and the mAgic
> > device code since 2009 without drivers. The ISI device at least is
> > supported on more than one variant, but only had code present for the
> > AT91SAM9263.
> 
> If they've not been merged for two to three years, they probably aren't
> going to ever be merged.  Removing them seems to be the right thing to
> do as they're not doing *anything* useful by remaining there.
> 
> They should be kept as part of the patch series adding the drivers.
The driver for isi was send the last year IIRC but no time to rebase it again

I need to clean the architecture first so keep it make sense

Best Regards,
J.
