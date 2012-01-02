From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 2 Jan 2012 14:33:57 +0100
Subject: [PATCH 12/12] ARM: restart: S3C24XX: use new restart hook
In-Reply-To: <20120102132631.GC18443@sirena.org.uk>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <201201021414.17551.heiko@sntech.de> <20120102132631.GC18443@sirena.org.uk>
Message-ID: <201201021433.57356.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 2. Januar 2012, 14:26:31 schrieb Mark Brown:
> On Mon, Jan 02, 2012 at 02:14:16PM +0100, Heiko St?bner wrote:
> > Therefore I'm introducing a new s3c2443-pm-common.c. Question now is,
> > should this move directly to plat-samsung?
> 
> If it's s3c2443 specific I'd expect it'd end up in the relevant mach
> directory?
nope, it's specific to 2443, 2416 and 2450. These three SoCs seem to share a 
lot of features and it seems other common code (i.e. plat-s3c24xx/s3c2443-
clock.c) has got its name from the first SoC that had this feature (the 
S3C2443 in 2007).

Therefore I just continue this naming scheme, as I also don't have a better 
idea on how to identify all three of them at once.

Heiko
