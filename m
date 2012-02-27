From: timur@freescale.com (Timur Tabi)
Date: Mon, 27 Feb 2012 15:39:04 -0600
Subject: [PATCH 5/6] ASoC: fsl: use platform_device_id table to match
 p1022_ds device
In-Reply-To: <1330092582-21180-6-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-6-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F4BF7F8.8030008@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:

> -
> -	/*
> -	 * Check if we're actually running on a P1022DS.  Older device trees
> -	 * have a model of "fsl,P1022" and newer ones use "fsl,P1022DS", so we
> -	 * need to support both.  The SSI driver uses that property to link to
> -	 * the machine driver, so have to match it.
> -	 */

Please retain this paragraph somewhere.  It's important to explain why
we're checking for both strings.

-- 
Timur Tabi
Linux kernel developer at Freescale
