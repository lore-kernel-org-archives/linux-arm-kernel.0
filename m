From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 03 Jan 2012 15:08:54 +0900
Subject: [PATCH 12/12] ARM: restart: S3C24XX: use new restart hook
In-Reply-To: <20120102133906.GP4300@opensource.wolfsonmicro.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <201201021414.17551.heiko@sntech.de> <20120102132631.GC18443@sirena.org.uk>
 <201201021433.57356.heiko@sntech.de>
 <20120102133906.GP4300@opensource.wolfsonmicro.com>
Message-ID: <00e201ccc9de$2ca008f0$85e01ad0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Mon, Jan 02, 2012 at 02:33:57PM +0100, Heiko St?bner wrote:
> > Am Montag, 2. Januar 2012, 14:26:31 schrieb Mark Brown:
> > > On Mon, Jan 02, 2012 at 02:14:16PM +0100, Heiko St?bner wrote:
> 
> > > > Therefore I'm introducing a new s3c2443-pm-common.c. Question now
is,
> > > > should this move directly to plat-samsung?
> 
> > > If it's s3c2443 specific I'd expect it'd end up in the relevant mach
> > > directory?
> 
> > nope, it's specific to 2443, 2416 and 2450. These three SoCs seem to
> share a
> > lot of features and it seems other common code (i.e. plat-
> s3c24xx/s3c2443-
> > clock.c) has got its name from the first SoC that had this feature (the
> > S3C2443 in 2007).
> 
> Oh, right - that's not terribly clear but I guess.

Heiko, I think your file can be placed in plat-s3c24xx/ now and if required,
I will move them into plat-samsung or just mach-s3c24xx. I mean I'm sorting
out the mach-s3c2410/, mach-s3c2412/, mach-s3c2416/, mach-s3c2440/ and
mach-s3c2443 directories too.

As a note, the working of one plat-samsung will be finished next time for
v3.4.

Happy New Year.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
