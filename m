From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 20 Jun 2011 16:06:41 +0300
Subject: [PATCH 2/2] video: omap2: Compile omap2 support only when needed
In-Reply-To: <1308566761-2850-3-git-send-email-tushar.behera@linaro.org>
References: <1308566761-2850-1-git-send-email-tushar.behera@linaro.org>
	<1308566761-2850-3-git-send-email-tushar.behera@linaro.org>
Message-ID: <1308575201.2076.57.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-06-20 at 16:16 +0530, Tushar Behera wrote:
> Currently display support for omap2 is selected by default and
> it gets built for all the configurations.
> 
> Instead of it being a built-in feature, it's compilation should
> depend on the config option CONFIG_FB_OMAP2.

No, I don't think so. omap2 directory contains vram, vrfb and omapdss,
all of which can be used without omapfb driver. vram and vrfb can be
even used without omapdss driver.

Is this patch fixing some real problem?

 Tomi
