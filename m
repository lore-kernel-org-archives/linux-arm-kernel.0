From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Fri, 2 Aug 2013 05:19:21 +0000
Subject: [PATCH v2 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
In-Reply-To: <20130801203301.GB5117@pengutronix.de>
References: <1371545327-12481-1-git-send-email-b35083@freescale.com>
 <20130801203301.GB5117@pengutronix.de>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851FBA70@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Using a struct type with a div and regval member would make the code
> surrounding this array more obviously correct. Would be nice to
> straighten this first before adding another array.
> 
> How about adding a regshift member instead? It seems shifting the vybrid
> registers by two bits is the imx registers.

 [Lu Jingchang-B35083] 
  Yes, using a struct for the i2c clock {div, regval} pairs would be more readable,
and the registers indeed have the same address offset.  I'll make some change and send
the v3 patch. Thanks!


Best Regards,
Jingchang
