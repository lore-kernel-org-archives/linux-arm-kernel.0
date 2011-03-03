From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 3 Mar 2011 18:48:25 +0800
Subject: [PATCH 1/2] ARM: imx5x: clean up ARCH_MX5X
In-Reply-To: <1299141603-22148-1-git-send-email-richard.zhao@freescale.com>
References: <1299141603-22148-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20110303104823.GC1655@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 04:40:02PM +0800, Richard Zhao wrote:
> Move to SOC_SOC_IMX5X. Leave only places which prevent multi-soc
          ^^^^^^^^^^^^^
SOC_IMX51?  Same question on SOC_SOC_IMX3X in the second patch.

> using ARCH_MX5X.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> 

-- 
Regards,
Shawn
