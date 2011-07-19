From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 19 Jul 2011 09:22:52 +0800
Subject: [PATCH 2/2] Input: gpio-keys: add device tree probe support
In-Reply-To: <201107181005.52725.dmitry.torokhov@gmail.com>
References: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
	<1311007508-8096-3-git-send-email-shawn.guo@linaro.org>
	<201107181005.52725.dmitry.torokhov@gmail.com>
Message-ID: <20110719012251.GC3838@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 10:05:52AM -0700, Dmitry Torokhov wrote:
> Hi Shawn,
> 
> On Monday, July 18, 2011 09:45:08 AM Shawn Guo wrote:
> > It adds device tree probe support for gpio-keys driver.
> 
> There is already a patch by David Jander adding device tree support to
> the driver; I intend to apply it.
> 
Sorry, I was not aware of David's patch.  No problem, you can pick
whichever you want.  All I want to see is gpio_keys gets device tree
support, because I need to convert several board files to device tree
and the gpio_keys seems to be the only one missing device tree support
there.

-- 
Regards,
Shawn
