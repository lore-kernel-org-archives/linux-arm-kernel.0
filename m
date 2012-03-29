From: timur@freescale.com (Timur Tabi)
Date: Thu, 29 Mar 2012 11:23:42 -0500
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
In-Reply-To: <20120329160916.GG19506@S2101-09.ap.freescale.net>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
 <20120329112949.GM3668@opensource.wolfsonmicro.com>
 <4F748751.3020300@freescale.com>
 <20120329160916.GG19506@S2101-09.ap.freescale.net>
Message-ID: <4F748C8E.1010702@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> d18b63ab0b04af1bad01e59a96b88fc8cda08752
> ASoC: core: Use driver core probe deferral

That fixed it, but the SHA in my repository is
97883ef0a8f61fbd5fb8242980f6998290d1dd95

Anyway, I just want to say that for-3.5 still works on PowerPC.

I do have one question though.  I don't know much about the clock layer.
When you do this:

	ssi_private->clk = clk_get(&pdev->dev, NULL);

What clock are you getting?

-- 
Timur Tabi
Linux kernel developer at Freescale
