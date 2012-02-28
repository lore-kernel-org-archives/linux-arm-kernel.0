From: B04825@freescale.com (Tabi Timur-B04825)
Date: Tue, 28 Feb 2012 02:12:53 +0000
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <20120228015012.GA13886@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <4F4BFB79.30801@freescale.com>
 <20120228015012.GA13886@S2101-09.ap.freescale.net>
Message-ID: <4F4C3824.90306@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> Since I was asked by Mark to use new binding for new machine driver,
> I would drop this patch and keep PowerPC machine drivers working with
> /model property.

I think Mark is only concerned with not breaking compatibility with 
existing device trees.  Both the P1022 and MPC8610 device trees have had 
this compatible property.

-- 
Timur Tabi
Linux kernel developer at Freescale
