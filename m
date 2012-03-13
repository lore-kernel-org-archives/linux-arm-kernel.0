From: timur@freescale.com (Timur Tabi)
Date: Tue, 13 Mar 2012 18:12:58 -0500
Subject: [PATCH v4 06/10] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <1331553537-19789-7-git-send-email-shawn.guo@linaro.org>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
 <1331553537-19789-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F5FD47A.9040808@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> Check /compatible rather than /model to determine the machine name.
> The p1022ds older device trees get a different /model from the new
> ones, while /compatible is consistent there, so checking /compatible
> will save the bother of detecting older p1022ds device trees.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

I'm pretty sure I ack'd this patch already.  Regardless, it does not apply
to for-3.4.

Applying: ASoC: fsl: check property 'compatible' for the machine name
error: patch failed: sound/soc/fsl/fsl_ssi.c:716
error: sound/soc/fsl/fsl_ssi.c: patch does not apply
error: patch failed: sound/soc/fsl/mpc8610_hpcd.c:402
error: sound/soc/fsl/mpc8610_hpcd.c: patch does not apply
error: patch failed: sound/soc/fsl/p1022_ds.c:403
error: sound/soc/fsl/p1022_ds.c: patch does not apply

-- 
Timur Tabi
Linux kernel developer at Freescale
