From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 02 Dec 2011 20:45:24 +0100
Subject: [PATCH] ARM: S3C64XX: Define some additional always off clocks
In-Reply-To: <20111202193747.GC4333@opensource.wolfsonmicro.com>
References: <1322841468-28431-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <29404566.LHT7QYyV2R@flatron>
 <20111202193747.GC4333@opensource.wolfsonmicro.com>
Message-ID: <3544285.l9RTi8aUql@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 of December 2011 19:37:48 Mark Brown wrote:
> On Fri, Dec 02, 2011 at 08:16:53PM +0100, Tomasz Figa wrote:
> > I have already done all the work needed to support the whole range of
> > clocks on S3C6410, but I can't find time to create and submit all the
> > patches.
> > 
> > (See: https://github.com/tom3q/spica-3.0/commits/android-
> > s3c64xx/arch/arm/mach-s3c64xx/clock.c if you are interested.)
> 
> A lot of good stuff in there - it's a bit of a shame you've not signed
> off any of the patches there.

Well, it's just an internal tree, not to be submitted right away. Some changes 
would need to be splitted into smaller ones, some joined. Probably some 
cleaning and rebasing would be also needed.
