From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 22 Sep 2011 23:04:01 +0800
Subject: [PATCH v2 2/2] ARM: smp_scu: remove __init annotation from
	scu_enable()
In-Reply-To: <20110917083236.GB26572@S2100-06.ap.freescale.net>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-3-git-send-email-shawn.guo@linaro.org>
	<20110917083236.GB26572@S2100-06.ap.freescale.net>
Message-ID: <20110922150359.GB15024@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 04:32:37PM +0800, Shawn Guo wrote:
> On Tue, Sep 06, 2011 at 01:48:27PM +0800, Shawn Guo wrote:
> > When Cortex-A9 MPCore resumes from Dormant or Shutdown modes,
> > SCU needs to be re-enabled.  This patch removes __init annotation
> > from function scu_enable(), so that platform resume procedure can
> > call it to re-enable SCU.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> 
> Hi Russell,
> 
> Do you have any comment on this patch?  Can I put it into patch tracker?
> 
Ping x 2.

As imx6q suspend support depends on this patch, I really need to know
if you will merge it.  Otherwise, I will probably have to copy the code
into imx6q platform code just like exynos4 is doing.

-- 
Regards,
Shawn
