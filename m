From: timur@freescale.com (Timur Tabi)
Date: Fri, 24 Feb 2012 10:32:50 -0600
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the machine
 name
In-Reply-To: <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F47BBB2.7090100@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> It seems the fsl_ssi PowerPC users, machine mpc8610_hpcd and p1022ds,
> basically have the same thing in model and compatible properties.
> Detecting machine name using compatible property becomes a solution
> working for both PowerPC and ARM users of fsl_ssi.

Do you actually have an 8610 or P1022 to test this?  I'm guessing the
answer is no.

-- 
Timur Tabi
Linux kernel developer at Freescale
