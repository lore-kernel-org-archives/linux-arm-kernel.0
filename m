From: B04825@freescale.com (Tabi Timur-B04825)
Date: Fri, 24 Feb 2012 02:59:22 +0000
Subject: [PATCH 1/4] ASoC: imx: add an explicit Kconfig option for
 imx-ssi driver
In-Reply-To: <20120224012850.GA4441@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
 <1330008519-3584-2-git-send-email-shawn.guo@linaro.org>
 <4F465DD0.1020304@freescale.com>
 <20120224012850.GA4441@S2101-09.ap.freescale.net>
Message-ID: <4F46FD09.5020700@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> That's what I'm doing.  But to be clear, imx-ssi driver will still
> exist for all those non-DT i.MX platforms.  We are supporting DT for
> imx5 and imx6, but have not seen a plan to migrate all those old i.MX
> platforms to DT.

On PowerPC, we handle this by creating cuImages.  These are kernel images 
that have a DTB built-in.  Perhaps something like that is needed for ARM?

-- 
Timur Tabi
Linux kernel developer at Freescale
