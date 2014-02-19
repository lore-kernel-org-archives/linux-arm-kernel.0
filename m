From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Feb 2014 14:03:12 +0800
Subject: [PATCH] ARM: dts: imx6sl-evk: Keep VGEN1 regulator always enabled
In-Reply-To: <20140219011957.GI15716@S2101-09.ap.freescale.net>
References: <1392752404-524-1-git-send-email-fabio.estevam@freescale.com>
 <20140219011957.GI15716@S2101-09.ap.freescale.net>
Message-ID: <20140219060307.GC3010@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 09:19:59AM +0800, Shawn Guo wrote:
> On Tue, Feb 18, 2014 at 04:40:04PM -0300, Fabio Estevam wrote:
> > On imx6sl-evk board the VGEN1 regulator powers up the NVCC_1.2V domain of the
> > imx6sl SoC, so we need to keep it always powered.
> > 
> > This problem has been observed by the fact that a GPIO connected to an LED could
> > not work when the PMIC driver was enabled.
> > 
> > Keeping VGEN1 regulator always enabled fixes the problem.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Applied, thanks.

Since Mark is questioning this is a correct fix, I'm dropping it for
now.

Shawn
