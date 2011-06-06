From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 6 Jun 2011 16:47:22 +0800
Subject: [PATCH 2/2] gpio/mxs: convert gpio-mxs to use basic_mmio_gpio
	library
In-Reply-To: <20110606081935.GG10410@ponder.secretlab.ca>
References: <1307341247-26382-1-git-send-email-shawn.guo@linaro.org>
	<1307341247-26382-2-git-send-email-shawn.guo@linaro.org>
	<20110606081935.GG10410@ponder.secretlab.ca>
Message-ID: <20110606084721.GB21204@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 02:19:35AM -0600, Grant Likely wrote:
> On Mon, Jun 06, 2011 at 02:20:47PM +0800, Shawn Guo wrote:
> > The gpio-mxs controller complies with basic_mmio_gpio library.  This
> > patch converts the driver to use the library.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Given that patch 1 was nacked, I'm assuming I should ignore this patch?
> 
Yes. I will send a v2 of this patch.

-- 
Regards,
Shawn
