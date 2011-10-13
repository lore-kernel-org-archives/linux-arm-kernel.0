From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Oct 2011 11:06:09 +0200
Subject: [PATCH 1/2] [ARM] mach-types: Re-add apf9328
In-Reply-To: <20111008220722.GG25689@n2100.arm.linux.org.uk>
References: <1318087189-22977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<20111008192621.GA28049@pengutronix.de>
	<20111008220722.GG25689@n2100.arm.linux.org.uk>
Message-ID: <20111013090609.GT577@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 08, 2011 at 11:07:22PM +0100, Russell King - ARM Linux wrote:
> On Sat, Oct 08, 2011 at 09:26:21PM +0200, Wolfram Sang wrote:
> > On Sat, Oct 08, 2011 at 05:19:48PM +0200, Gwenhael Goavec-Merou wrote:
> > > 
> > > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> > 
> > I think this file is maintained by Russell, yet I want to ack that the entry
> > below is missing for building mx1_defconfig. Found that, too.
> 
> The thing is - read the comments at the top of the file.  There's hints
> there as to what will happen if you patch the file.  The hint is
> 'automatically generated'.  So when I next update the file, any patches
> done to the file will be wiped out.
Currently the id is still missing in your for-next branch and it is
marked as "mainlined" on http://www.arm.linux.org.uk/developer/machines/
(906).

That means that the next update should include the id, right? Maybe it's
worth to add it already earlier with the patch Gwenhael proposed as
without it mx1_defconfig is broken. After f32609c5a035 it even breaks
imx_v4_v5_defconfig.

BTW is there a way to see the mach-types file as it would land in
linux.git if it were updated now?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
