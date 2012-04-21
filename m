From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 22 Apr 2012 00:16:09 +0800
Subject: [PATCH v2] ARM: dts: Add basic support for imx6q-sabresd
In-Reply-To: <1334941838-18470-1-git-send-email-fabio.estevam@freescale.com>
References: <1334941838-18470-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120421161606.GA26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 02:10:38PM -0300, Fabio Estevam wrote:
> Add basic support for imx6q-sabresd.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> 
> - Added entry into Documentation
> - Added entry in arch/arm/mach-imx/Makefile.boot
> - Fixed ethernet
> - Dropped SDHC for now
> 
Instead of dropping SDHC, I would expect only drop vmmc-supply property
of the SDHC node, as SD still works without that.  Also, I have seen at
least 2 SD slots on the board.

-- 
Regards,
Shawn
