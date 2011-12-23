From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 23 Dec 2011 10:37:44 +0000
Subject: [PATCH v3 1/9] include: platform_data: Platform data header for
 OMAP4 ASoC audio
In-Reply-To: <1324582474-18181-2-git-send-email-peter.ujfalusi@ti.com>
References: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
 <1324582474-18181-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20111223103744.GC2834@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 09:34:26PM +0200, Peter Ujfalusi wrote:

>  include/linux/platform_data/omap-abe-twl6040.h |   48 ++++++++++++++++++++++++

I have to say I'm still really unhappy with the name - it's not like we
should ever be seeing an omap-twl6040 driver but the naming suggests
that there should be.  Bypassing the ABE ought to be a runtime decision
as it's policy and might change with use case.  But anyway:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
