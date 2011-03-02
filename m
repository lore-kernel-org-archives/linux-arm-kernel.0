From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Mar 2011 17:54:43 +0800
Subject: [RFC PATCH 1/1] ARM: imx5x: clean up ARCH_MX5X
In-Reply-To: <1299036526-15674-1-git-send-email-richard.zhao@freescale.com>
References: <1299036526-15674-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20110302095442.GB21601@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 11:28:46AM +0800, Richard Zhao wrote:
> Remove legacy support of ARCH_MX5X. Move to SOC_SOC_IMX5X.
> 
+1

As SOC_IMXxx is introduced, ARCH_MXxx seems a little bit messy to me.

-- 
Regards,
Shawn
