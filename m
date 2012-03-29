From: timur@freescale.com (Timur Tabi)
Date: Thu, 29 Mar 2012 11:01:21 -0500
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
In-Reply-To: <20120329112949.GM3668@opensource.wolfsonmicro.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
 <20120329112949.GM3668@opensource.wolfsonmicro.com>
Message-ID: <4F748751.3020300@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> Applied, thanks (though checking return codes would be nice).  

Speaking of return codes, I can't even get ASoC for-3.5 to compile:

/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
'soc_bind_dai_link':
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:805:11: error:
'EPROBE_DEFER' undeclared (first use in this function)
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:805:11: note: each
undeclared identifier is reported only once for each function it appears in
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
'soc_check_aux_dev':
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1346:10: error:
'EPROBE_DEFER' undeclared (first use in this function)
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
'soc_probe_aux_dev':
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1369:10: error:
'EPROBE_DEFER' undeclared (first use in this function)
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
'soc_check_aux_dev':
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1347:1: warning:
control reaches end of non-void function



-- 
Timur Tabi
Linux kernel developer at Freescale
