From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Jun 2016 03:06:05 -0700
Subject: [PATCH] ARM: OMAP: make ti81xx_rtc_hwmod static
In-Reply-To: <1466513236-23528-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466513236-23528-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160622100604.GI22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ben Dooks <ben.dooks@codethink.co.uk> [160621 05:50]:
> The ti81xx_rtc_hwmod is not exported, or declared outside the file
> arch/arm/mach-omap2/omap_hwmod_81xx_data.c so make it static to
> avoid the following warning:

Thanks applying into omap-for-v4.8/soc.

Tony
