From: timur@freescale.com (Timur Tabi)
Date: Thu, 8 Mar 2012 14:50:47 -0600
Subject: [PATCH v3 07/11] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <1331225990-27308-8-git-send-email-shawn.guo@linaro.org>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-8-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F591BA7.2050602@freescale.com>
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

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
