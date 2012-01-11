From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 11 Jan 2012 21:02:44 +0800
Subject: [PATCH 5/6] ARM: mxc: add dt support for audmux-v2
In-Reply-To: <20120111052603.GA28509@S2101-09.ap.freescale.net>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-6-git-send-email-richard.zhao@linaro.org>
 <20120106091315.GG5446@pengutronix.de>
 <20120106092124.GT2414@b20223-02.ap.freescale.net>
 <20120111052603.GA28509@S2101-09.ap.freescale.net>
Message-ID: <20120111130243.GB27484@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 01:26:06PM +0800, Shawn Guo wrote:
> On Fri, Jan 06, 2012 at 05:21:24PM +0800, Richard Zhao wrote:
> > You are right. Look like I have to convert audmux to platform devices
> > for all platforms.
> > 
> With doing so, it may be also good for us to move this driver into
> sound/soc/imx/.  Any particular reason to keep it in platform?
Yes, we can move it out. But I'm not sure we can put it in asoc,
because it's not a standard part of ASoC. Mark?

Thanks
Richard
> 
> -- 
> Regards,
> Shawn
> 
