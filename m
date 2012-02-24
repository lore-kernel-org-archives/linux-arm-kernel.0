From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 25 Feb 2012 07:23:01 +0800
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <4F47BBB2.7090100@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <4F47BBB2.7090100@freescale.com>
Message-ID: <20120224232259.GB24268@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 10:32:50AM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > It seems the fsl_ssi PowerPC users, machine mpc8610_hpcd and p1022ds,
> > basically have the same thing in model and compatible properties.
> > Detecting machine name using compatible property becomes a solution
> > working for both PowerPC and ARM users of fsl_ssi.
> 
> Do you actually have an 8610 or P1022 to test this?  I'm guessing the
> answer is no.
> 
No, I do not.  I only compile-tested it.  I need your favor here.

-- 
Regards,
Shawn
