From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 14:45:22 +0800
Subject: [PATCH 22/33] ARM: imx: add common clock support for pllv3
In-Reply-To: <20120427063203.GN17184@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-23-git-send-email-s.hauer@pengutronix.de>
 <20120427062120.GL2234@S2101-09.ap.freescale.net>
 <20120427063203.GN17184@pengutronix.de>
Message-ID: <20120427064520.GN2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 08:32:03AM +0200, Sascha Hauer wrote:
> The set_rate prototype has changed, round_rate not, so I missed this.
> Will fix.
> 
And clk-pfd.c needs the same fix.

-- 
Regards,
Shawn
