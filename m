From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 9 Mar 2013 21:31:59 +0100
Subject: [GIT PULL] preparation patches for Cortex-M3
In-Reply-To: <20130308233733.GD4977@n2100.arm.linux.org.uk>
References: <20130307151138.GI15375@pengutronix.de>
 <20130308233733.GD4977@n2100.arm.linux.org.uk>
Message-ID: <20130309203159.GM15375@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, Mar 08, 2013 at 11:37:34PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 07, 2013 at 04:11:38PM +0100, Uwe Kleine-K?nig wrote:
> > Hello Russell,
> > 
> > the following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:
> > 
> >   Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.pengutronix.de/git/ukl/linux.git for-next
> > 
> > for you to fetch changes up to 6ebd4d038dbb626a43d87db3007e71f92f49d7b3:
> > 
> >   ARM: stub out read_cpuid and read_cpuid_ext for CPU_CP15=n (2013-01-31 21:44:48 +0100)
> > 
> > These are in next since next-20130213 without any problem reports.
> > 
> > I currently base my Cortex-M3 stuff on top of these. The complete series
> > still has some problems though that I have to debug first. I'd be glad
> > if you'd pull at least this series for 3.10.
> 
> Okay, and you of course did try doing a test-merge with something like
> v3.9-rc1 before sending this pull request, so you know about these
> conflicts - which I've fixed up like this.  Does this look sensible?
I should have mentioned the conflict resolution in next is fine. Your's
is slightly different, but even better.

I documented to point out merge conflicts for future pull requests in my
check list, so I expect to do better next time.

Thanks for pulling and the conflict handling
Uwe
