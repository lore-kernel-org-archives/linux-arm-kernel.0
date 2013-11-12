From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 13 Nov 2013 00:20:21 +0100
Subject: [PATCH v2 10/19] mtd: sh_flctl: Enable the driver on all ARM
 platforms
In-Reply-To: <20131112231719.GB9468@ld-irv-0074.broadcom.com>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1701001.ctJ1xUAsnV@avalon> <20131112231719.GB9468@ld-irv-0074.broadcom.com>
Message-ID: <3733738.K29aNVltiz@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Tuesday 12 November 2013 15:17:19 Brian Norris wrote:
> On Wed, Nov 13, 2013 at 12:14:37AM +0100, Laurent Pinchart wrote:
> > On Tuesday 12 November 2013 15:10:20 Brian Norris wrote:
> > > On Tue, Oct 29, 2013 at 11:37:45PM +0100, Laurent Pinchart wrote:
> > > > Renesas ARM platforms are transitioning from single-platform to
> > > > multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> > > > driver available on all ARM platforms to enable it on both
> > > > ARCH_SHMOBILE
> > > > and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
> > > > COMPILE_TEST.
> > > > 
> > > > Cc: David Woodhouse <dwmw2@infradead.org>
> > > > Cc: linux-mtd at lists.infradead.org
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > Applied to l2-mtd.git, branch 'next' (for 3.14). Thanks.
> > 
> > Thank you, but if it's not too late, can you drop the patch ? :-) We've
> > settled for a different approach that renames Kconfig symbols and doesn't
> > require changes to individual drivers.
> 
> No problem. It's dropped.

Thank you.

> I was only paying attention to the cover letter, where that decision
> apparently didn't show up :)

I'll reply to the cover letter. Sorry about that.

-- 
Regards,

Laurent Pinchart
