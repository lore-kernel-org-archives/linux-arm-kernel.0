From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Jan 2010 12:49:27 +0000
Subject: [PATCH 1/3] ARM: SAMSUNG: Add config option for number of
	additional GPIO pins.
In-Reply-To: <20100111122715.GG1224@trinity.fluff.org>
References: <1263203046-29219-1-git-send-email-kgene.kim@samsung.com>
	<20100111103338.GA3440@sirena.org.uk>
	<20100111122715.GG1224@trinity.fluff.org>
Message-ID: <20100111124927.GB27161@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 12:27:15PM +0000, Ben Dooks wrote:

> Having this as a user settable field might be useful if plugging on
> GPIO expanders at runtime.

If that gets to be anything other than an extremely niche use case the
GPIO allocation would need to have a dynamic limit anyway, though.
