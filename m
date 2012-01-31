From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Jan 2012 23:28:29 +0800
Subject: [PATCH v3] ARM: mxs: Use a proper timeout mechanism
In-Reply-To: <1327675469-11342-1-git-send-email-fabio.estevam@freescale.com>
References: <1327329667-25512-1-git-send-email-fabio.estevam@freescale.com>
 <1327675469-11342-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120131152826.GD26436@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 12:44:29PM -0200, Fabio Estevam wrote:
> Introduce a function for checking the busy bits of CLKCTRL register that 
> uses a proper timeout mechanism.
> 
> Remove parts of code that use busy loops and replace them with the 
> mxs_clkctrl_timeout() function.
> 
> Tested on a mx28evk by performing audio playback.
> 
> Suggested-by: Wolfram Sang <w.sang@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

-- 
Regards,
Shawn
