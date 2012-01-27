From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Jan 2012 17:58:57 +0000
Subject: [alsa-devel] [PATCH v4 - resend 11/13] ASoC: omap-abe-twl6040:
 Use provided MCLK frequency from pdata
In-Reply-To: <1327405950-6676-12-git-send-email-peter.ujfalusi@ti.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
 <1327405950-6676-12-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120127175857.GA29026@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 01:52:28PM +0200, Peter Ujfalusi wrote:
> Avoid using hardwired configuration for MCLK frequency.
> Different board design might use other MCLK frequency.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

So, apparently this one isn't an actual resend!  Since you flagged the
entire series up as a resend I didn't actually read it as I'd presumably
already reviewed it.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
