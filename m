From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 15 Nov 2011 11:27:10 +0800
Subject: [PATCH v2] ARM: mach-imx: convert logical CPU numbers to
 physical numbers
In-Reply-To: <1321289096-28679-1-git-send-email-will.deacon@arm.com>
References: <1321289096-28679-1-git-send-email-will.deacon@arm.com>
Message-ID: <20111115032708.GA10701@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2011 at 04:44:56PM +0000, Will Deacon wrote:
> This patch uses the new cpu_logical_map() macro for converting logical
> CPU numbers into physical numbers when releasing CPUs during the SMP
> boot and CPU hotplug paths.
> 
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: <shawn.guo@linaro.org>

-- 
Regards,
Shawn
