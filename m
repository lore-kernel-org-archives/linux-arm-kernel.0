From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Mar 2012 17:30:06 +0100
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
In-Reply-To: <4F748751.3020300@freescale.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
 <20120329112949.GM3668@opensource.wolfsonmicro.com>
 <4F748751.3020300@freescale.com>
Message-ID: <20120329163005.GV3668@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 11:01:21AM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> > Applied, thanks (though checking return codes would be nice).  

> Speaking of return codes, I can't even get ASoC for-3.5 to compile:

> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
> 'soc_bind_dai_link':
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:805:11: error:
> 'EPROBE_DEFER' undeclared (first use in this function)

It only works on top of Linus' tree, I'll be rebasing it once -rc1 comes
out.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120329/af107ce7/attachment.sig>
