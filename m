From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 May 2015 20:22:54 +0800
Subject: [PATCH] imx: thermal: use CPU temperature grade info for
 thresholds
In-Reply-To: <1430409757-16195-1-git-send-email-tharvey@gateworks.com>
References: <1430409757-16195-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20150511122253.GA9347@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 09:02:37AM -0700, Tim Harvey wrote:
> The IMX6Q/IMX6DL SoC's have a 2-bit temperature grade stored in OTP. Instead
> of assuming 85C for passive cooling threshold and 105C for critical use
> the thermal grade for these configurations. For IMX6SX which does not have
> a temperature grade in OTP (according to the ref manual) assume 105C critical.
> We will default the user-settable passive threshold to crit - 20C.
> 
> Cc: Anson Huang <b20788@freescale.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

I'm fine with the patch.  But it'd be good to have Anson look at it as
well.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
