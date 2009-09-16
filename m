From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Sep 2009 19:49:14 +0100
Subject: [PATCH 02/10] S3C64XX I2S: declared i2s_v4
In-Reply-To: <1253008954-10473-1-git-send-email-jassi.brar@samsung.com>
References: <1253008954-10473-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090916184914.GB6257@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:34PM +0900, Jassi wrote:

>  arch/arm/mach-s3c6410/mach-smdk6410.c |    1 +
>  arch/arm/plat-s3c/dev-audio.c         |    6 ++++--

This won't apply against the current code, dev-audio.c is now in
plat-s3c64xx.  Please check that you're working against current code
when submitting things otherwise people aren't going to be able to apply
your patches.  The -next tree is helpful for this.
