From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 19 Feb 2014 11:33:20 +0100
Subject: [GIT PULL v2] get rid of <mach/timex.h>
In-Reply-To: <20140219064104.GA24381@quad.lixom.net>
References: <20140218213736.GA6988@pengutronix.de>
 <20140219064104.GA24381@quad.lixom.net>
Message-ID: <20140219103319.GB6988@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

On Tue, Feb 18, 2014 at 10:41:04PM -0800, Olof Johansson wrote:
> > The series still creates the same merge conflicts when being pulled into
> > linus/master. See
> > http://git.pengutronix.de/?p=ukl/linux.git;a=commitdiff;h=dropmachtimexh-merged
> > for how I resolved for the first pull request.
> > 
> > It would be great to get this merged into v3.15-rc1.
> 
> Merged in as cleanup/timex-removal into next/cleanup.
> 
> Note that your conflict resolution was incorrect at least for the
> mach-sa1100 case, where the SA1100_LATCH define is still needed.
Your resolution looks correct. SA1100_LATCH was missing from mine
because my -merged branch was based on an earlier pull request that
had the "ARM: sa1100: stop using mach/timex.h" broken with respect to
LATCH. I redid the merge on top of v3.14-rc3 that you used as base, too,
and got to the exact same merge resolution as you.

Thanks for picking up my series
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
