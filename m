From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Jun 2014 16:04:03 +0200
Subject: [PATCH 1/2] [RFC] ASoC: samsung: move s3c24xx over to dmaengine
In-Reply-To: <20140605133606.GX2520@sirena.org.uk>
References: <6123933.aGtaUr149J@wuerfel> <20140605133606.GX2520@sirena.org.uk>
Message-ID: <4306380.m7SZhHfhaK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 June 2014 14:36:06 Mark Brown wrote:
> On Thu, Jun 05, 2014 at 03:20:50PM +0200, Arnd Bergmann wrote:
> > The s3c24xx sound support keeps giving randconfig build errors, this
> > is a new attempt to solve it by moving the driver over to use dmaengine
> > exclusively.
> 
> We already have a patch pending for this, it's just waiting until after
> the merge window to avoid bisection breakage since it depends on
> dmaengine changes.

Ok, very good.

	Arnd
