From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Dec 2011 13:48:14 +0800
Subject: [PATCH 0/7] arm/imx6: add imx6q sabrelite board and imx6q
 cpufreq support
In-Reply-To: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111212054813.GE9572@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 11:42:25AM +0800, Richard Zhao wrote:
> - add imx6q sabrelite board support
> - add imx6q cpufreq support
> 
It seems that Rob Lee is also working on imx6q cpufreq.  We had some
talk about this.  I would suggest move the existing imx cpufreq driver
into drivers/cpufreq before we start adding imx6q support.  (Samsung
and Omap have already done that.)

-- 
Regards,
Shawn
