From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jan 2012 13:26:31 +0000
Subject: [PATCH 12/12] ARM: restart: S3C24XX: use new restart hook
In-Reply-To: <201201021414.17551.heiko@sntech.de>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <201112201418.07935.heiko@sntech.de> <4EF08F02.9010604@samsung.com>
 <201201021414.17551.heiko@sntech.de>
Message-ID: <20120102132631.GC18443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 02:14:16PM +0100, Heiko St?bner wrote:

> Therefore I'm introducing a new s3c2443-pm-common.c. Question now is, should 
> this move directly to plat-samsung?

If it's s3c2443 specific I'd expect it'd end up in the relevant mach
directory?
