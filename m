From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Feb 2012 11:37:52 +0800
Subject: [PATCH 1/4] ASoC: imx: add an explicit Kconfig option for
 imx-ssi driver
In-Reply-To: <4F46FD09.5020700@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-2-git-send-email-shawn.guo@linaro.org>
 <4F465DD0.1020304@freescale.com>
 <20120224012850.GA4441@S2101-09.ap.freescale.net>
 <4F46FD09.5020700@freescale.com>
Message-ID: <20120224033750.GB4441@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 02:59:22AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > That's what I'm doing.  But to be clear, imx-ssi driver will still
> > exist for all those non-DT i.MX platforms.  We are supporting DT for
> > imx5 and imx6, but have not seen a plan to migrate all those old i.MX
> > platforms to DT.
> 
> On PowerPC, we handle this by creating cuImages.  These are kernel images 
> that have a DTB built-in.  Perhaps something like that is needed for ARM?
> 
We have the similar support on ARM (dtb can be appended to zImage).
It resolves the problem that boot loader does not support DT.  However
what I'm saying is that we do not have a plan to add DT support for
those old i.MX SoCs like imx1, imx2, imx3 in kernel.  That said, the
kernel running on those platforms are not aware of DT.

-- 
Regards,
Shawn
