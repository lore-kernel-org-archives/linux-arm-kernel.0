From: B04825@freescale.com (Tabi Timur-B04825)
Date: Tue, 28 Feb 2012 03:42:57 +0000
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <20120228031308.GI13886@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <4F4BFB79.30801@freescale.com>
 <20120228015012.GA13886@S2101-09.ap.freescale.net>
 <4F4C3824.90306@freescale.com>
 <20120228031308.GI13886@S2101-09.ap.freescale.net>
Message-ID: <4F4C4D3F.3070907@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> Are you saying that both older and new P1022 device trees have
> compatible = "fsl,P1022DS", so that changing to check /compatible
> could save the check on /model of P1022 device tree?

Yes, that's what I'm saying.

You can verify for yourself by looking at the git history of the device trees.

-- 
Timur Tabi
Linux kernel developer at Freescale
