From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Feb 2012 11:13:11 +0800
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <4F4C3824.90306@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <4F4BFB79.30801@freescale.com>
 <20120228015012.GA13886@S2101-09.ap.freescale.net>
 <4F4C3824.90306@freescale.com>
Message-ID: <20120228031308.GI13886@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 02:12:53AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > Since I was asked by Mark to use new binding for new machine driver,
> > I would drop this patch and keep PowerPC machine drivers working with
> > /model property.
> 
> I think Mark is only concerned with not breaking compatibility with 
> existing device trees.  Both the P1022 and MPC8610 device trees have had 
> this compatible property.
> 
Are you saying that both older and new P1022 device trees have
compatible = "fsl,P1022DS", so that changing to check /compatible
could save the check on /model of P1022 device tree?  Otherwise,
the check between "fsl,P1022" and "fsl,P1022DS" can not be saved.

-- 
Regards,
Shawn
