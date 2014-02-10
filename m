From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Feb 2014 10:29:06 +0000
Subject: [PATCH] staging: drm/imx: remove an unnecessary local variable
In-Reply-To: <1392028185-4528-1-git-send-email-Ying.Liu@freescale.com>
References: <1392028185-4528-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20140210102906.GP26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 06:29:45PM +0800, Liu Ying wrote:
> This patch removes an unnecessary local variable defined
> in the function imx_drm_driver_unload() so as to fix the
> following build warning.
> 
> drivers/staging/imx-drm/imx-drm-core.c: \
> In function ?imx_drm_driver_unload?:
> drivers/staging/imx-drm/imx-drm-core.c:87:25: \
> warning: unused variable ?imxdrm? [-Wunused-variable]

Already-Naked-by: me.  This is required by later patches in the series
posted earlier.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
