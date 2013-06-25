From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Jun 2013 22:22:58 +0800
Subject: [PATCH 2/3] ARM: dts: mx28: Provide a codec clock
In-Reply-To: <1372168801-4221-2-git-send-email-fabio.estevam@freescale.com>
References: <1372168801-4221-1-git-send-email-fabio.estevam@freescale.com>
 <1372168801-4221-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130625142257.GE12178@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 11:00:00AM -0300, Fabio Estevam wrote:
> Since commit 9e13f345887 (ASoC: sgtl5000: Let the codec acquire its clock) it is 
> necessary to pass a codec clock to the sgtl5000 driver.
> 
> Since the saif mclk cannot be passed as a real clock within the clock framework,
> let's pass a dummy one to the codec driver.
> 
Why can not saif driver register the mclk to clock framework?

Shawn

> The mxs-saif driver will activate the codec clock.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
