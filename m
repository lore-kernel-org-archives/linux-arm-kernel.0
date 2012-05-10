From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 14:39:06 +0800
Subject: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
In-Reply-To: <20120510003532.GG2982@b20223-02.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
 <20120509160005.GG3955@opensource.wolfsonmicro.com>
 <20120510003532.GG2982@b20223-02.ap.freescale.net>
Message-ID: <20120510063904.GB17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 08:35:33AM +0800, Richard Zhao wrote:
> On Wed, May 09, 2012 at 05:00:06PM +0100, Mark Brown wrote:
> > On Wed, May 09, 2012 at 07:33:02PM +0800, Richard Zhao wrote:
> > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > 
> > I guess this depends on some other tree and can't just be directly
> > applied to ASoC?
> It's based on your for-next. But for working, it depends on
> pinctl/for-next.
> 
Mark, may I have your ack to have it go through arm-soc?  I will ask
Arnd pull your sound/for-v3.5 branch into arm-soc as a dependency.
You need to ensure the branch will not be rebased.

-- 
Regards,
Shawn
