From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Mar 2012 17:30:59 +0100
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
In-Reply-To: <4F748C8E.1010702@freescale.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
 <20120329112949.GM3668@opensource.wolfsonmicro.com>
 <4F748751.3020300@freescale.com>
 <20120329160916.GG19506@S2101-09.ap.freescale.net>
 <4F748C8E.1010702@freescale.com>
Message-ID: <20120329163059.GW3668@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 11:23:42AM -0500, Timur Tabi wrote:

> I do have one question though.  I don't know much about the clock layer.
> When you do this:

> 	ssi_private->clk = clk_get(&pdev->dev, NULL);

> What clock are you getting?

The default clock - personally I much prefer always naming the clocks
even if there's one of them but more people seem to prefer this style.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120329/ffaf352d/attachment.sig>
