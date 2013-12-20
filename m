From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Dec 2013 09:34:48 +0800
Subject: i.MX35 devicetree support
In-Reply-To: <1387375826-4018-1-git-send-email-s.hauer@pengutronix.de>
References: <1387375826-4018-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20131220013445.GG6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 03:10:24PM +0100, Sascha Hauer wrote:
> This adds devicetree support for the i.MX35. This was originally made
> by Steffen Trumtrar and later continued by Denis Carikli. Changes since
> the last posting from Denis (v8, Nov 12 2013):
> 
> - use CLK_OF_DECLARE as requested by Shawn
> - add usb devicetree nodes
> - add spi devicetree nodes
> - add cpus devicetree node
> - split uart pin groups into txd,rxd / rts,cts
> 
> Sascha
> 
> ----------------------------------------------------------------
> Steffen Trumtrar (2):
>       ARM i.MX35: Add devicetree support.
>       ARM: dts: Add support for the i.MX35.

Applied both, after dropping imx35_timer_init() hook and clocks node.

Shawn
