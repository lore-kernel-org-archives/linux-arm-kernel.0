From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 21 Jan 2010 10:11:29 +0000
Subject: [PATCH 1/2] S3C64XX: Staticise audio platform data
In-Reply-To: <20100121014530.GY10014@trinity.fluff.org>
References: <1263992765-28479-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100121014530.GY10014@trinity.fluff.org>
Message-ID: <20100121101128.GA21621@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 01:45:30AM +0000, Ben Dooks wrote:
> On Wed, Jan 20, 2010 at 01:06:04PM +0000, Mark Brown wrote:
> > It's not exported.

> applied these all to next-samsung-s3c64xx2, will merge into next-samsung

> next time, please add ARM: to the prefix, it would save time when applying
> to the tree.

Is that definite?  The ARM generic bit of the prefix seems to waver
between [ARM] and ARM:.
