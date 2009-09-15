From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 13:30:12 +0100
Subject: [PATCH 06/10] S3C I2S: LRCLK polarity option.
In-Reply-To: <1253008958-10601-1-git-send-email-jassi.brar@samsung.com>
References: <1253008958-10601-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915123012.GQ22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:38PM +0900, Jassi wrote:
> 1) Explicitly set LRCLK polarity for I2S Vs LSM/MSB modes.
> 2) Convert from numerical to bit-field values for BCLK selection.
> 3) Use proper error checking for return value from clk_get

> Signed-Off-by: Jassi <jassi.brar@samsung.com>

I'll apply this for 2.6.33 - the errors aren't that serious (I'd be
surprised to see anyone choose left or right justified modes at all).
