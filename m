From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Sep 2009 21:12:30 +0100
Subject: [PATCH 03/10] S3C64XX I2S: Codec Clock Gating Option
In-Reply-To: <20090916110246.GD3589@rakim.wolfsonmicro.main>
References: <1253008955-10505-1-git-send-email-jassi.brar@samsung.com>
	<20090915104417.GF22878@rakim.wolfsonmicro.main>
	<1b68c6790909151837x35cc7171y42c6a612975052ee@mail.gmail.com>
	<20090916110246.GD3589@rakim.wolfsonmicro.main>
Message-ID: <20090916201230.GJ3589@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 12:02:46PM +0100, Mark Brown wrote:

> There's no meaningful extra effort required to do this properly and
> given that all this patch does is implement an external interface it's
> better to just get it right rather than spend the effort on fixups (and
> merge issues).

I added the following patch to implement this, not tested yet.
