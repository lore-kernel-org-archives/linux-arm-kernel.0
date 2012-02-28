From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Feb 2012 13:35:39 +0800
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <4F4C4D3F.3070907@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <4F4BFB79.30801@freescale.com>
 <20120228015012.GA13886@S2101-09.ap.freescale.net>
 <4F4C3824.90306@freescale.com>
 <20120228031308.GI13886@S2101-09.ap.freescale.net>
 <4F4C4D3F.3070907@freescale.com>
Message-ID: <20120228053537.GJ13886@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 03:42:57AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > Are you saying that both older and new P1022 device trees have
> > compatible = "fsl,P1022DS", so that changing to check /compatible
> > could save the check on /model of P1022 device tree?
> 
> Yes, that's what I'm saying.
> 
Ok, I will drop "[PATCH 5/6] ASoC: fsl: use platform_device_id table
to match p1022_ds device" and move to this then.

-- 
Regards,
Shawn
