From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 14:37:24 +0800
Subject: [PATCH 7/7] ARM i.MX5: Add system reset controller (SRC) to
 i.MX51 and i.MX53 device tree
In-Reply-To: <50F72780.8040208@wwwdotorg.org>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-8-git-send-email-p.zabel@pengutronix.de>
 <50F72780.8040208@wwwdotorg.org>
Message-ID: <20130117063722.GL26179@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 03:19:44PM -0700, Stephen Warren wrote:
> On 01/16/2013 09:13 AM, Philipp Zabel wrote:
> > Also, link SRC to IPU via phandle.
> 
> Aside from the comments I already made, the series,
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> 
> although I'm not 100% sure if the ordering of patches maintains a
> working i.MX build all the time? Does "git bisect" work across the series?
> 
> Who would merge these patches?

I would assume IMX --> arm-soc --> mainline?

Philipp, please copy arm-soc folks (Arnd and Olof) on the next post,
so that they can get a chance to review this tiny reset subsystem.

Shawn
