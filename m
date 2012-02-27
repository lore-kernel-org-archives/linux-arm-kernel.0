From: timur@freescale.com (Timur Tabi)
Date: Mon, 27 Feb 2012 12:15:29 -0600
Subject: [PATCH 4/6] ASoC: fsl: create fsl_utils to accommodate the common
 functions
In-Reply-To: <1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F4BC841.7000407@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> There are some amount of code duplication between mpc8610_hpcd and
> p1022_ds machine drivers, and the same code will be duplicated again
> when another new machine driver is added.  The patch creates fsl_utils
> to accommodate the common functions to stop the code duplication.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

What repository is this for?  When I apply it to Mark's for-next branch, I
get this:

Applying: ASoC: fsl: create fsl_utils to accommodate the common functions
error: patch failed: sound/soc/fsl/Kconfig:1
error: sound/soc/fsl/Kconfig: patch does not apply
error: patch failed: sound/soc/fsl/Makefile:8
error: sound/soc/fsl/Makefile: patch does not apply
Patch failed at 0004 ASoC: fsl: create fsl_utils to accommodate the common
functions
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

-- 
Timur Tabi
Linux kernel developer at Freescale
