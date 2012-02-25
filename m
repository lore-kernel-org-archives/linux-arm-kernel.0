From: B04825@freescale.com (Tabi Timur-B04825)
Date: Sat, 25 Feb 2012 14:03:56 +0000
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <20120225132705.GA3412@opensource.wolfsonmicro.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <20120224141207.GI5450@opensource.wolfsonmicro.com>
 <20120225012845.GF24268@S2101-09.ap.freescale.net>
 <20120225114227.GB3167@opensource.wolfsonmicro.com>
 <20120225130943.GB25201@S2101-09.ap.freescale.net>
 <20120225132705.GA3412@opensource.wolfsonmicro.com>
Message-ID: <4F48EA4B.4030400@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:

> Nobody's suggesting that they don't get merged if they really are the
> same IP and can use the same code.  The device tree bindings are (and
> should be) a really small proportion of the code.

My understanding is that they really are the same exact IP.

> The CODEC binding for the machine driver is part of the SSI binding, and
> a mandatory one at that.  It looks like the code should be refactored to
> register the SSI unconditionally

Ok.

> and then optionally also register a
> machine driver if there's a CODEC property present.

Ah, that's not a bad idea.  I like that.

-- 
Timur Tabi
Linux kernel developer at Freescale
