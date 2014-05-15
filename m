From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 May 2014 14:25:53 +0200
Subject: [PATCH] ARM: imx: remove check for CONFIG_SDMA_IRAM
In-Reply-To: <1400140671.20469.7.camel@x220>
References: <1400140671.20469.7.camel@x220>
Message-ID: <20140515122553.GF5858@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, May 15, 2014 at 09:57:51AM +0200, Paul Bolle wrote:
> A check for CONFIG_SDMA_IRAM was added in v2.6.34. But the Kconfig
> symbol SDMA_IRAM was never added. Remove this check.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
> Note that none of the MX51_MXC_DMA_CHANNEL_* macros are actually used.
> Why are they needed?

All these can be removed. They came in with the initial i.MX5 commit and
were never meaningful in a mainline kernel.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
