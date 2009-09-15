From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 11:56:39 +0100
Subject: [PATCH 06/10] S3C I2S: LRCLK polarity option.
In-Reply-To: <1253008958-10601-1-git-send-email-jassi.brar@samsung.com>
References: <1253008958-10601-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915105638.GG22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:38PM +0900, Jassi wrote:
> 1) Explicitly set LRCLK polarity for I2S Vs LSM/MSB modes.
> 2) Convert from numerical to bit-field values for BCLK selection.
> 3) Use proper error checking for return value from clk_get

This is three separate patches you've merged into one here...  Ideally
at least patch 3 and possibly also patch 1 ought to be applied as bug
fixes for 2.6.32 but you've mixed them all together for some reason?
