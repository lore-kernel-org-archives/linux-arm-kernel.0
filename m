From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Nov 2014 14:55:42 +0000
Subject: [PATCH 2/4] spi: st: Provide Device Tree binding documentation
In-Reply-To: <20141127130053.GW7712@sirena.org.uk>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-3-git-send-email-lee.jones@linaro.org>
 <20141127130053.GW7712@sirena.org.uk>
Message-ID: <20141127145542.GH4628@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Nov 2014, Mark Brown wrote:

> On Thu, Nov 27, 2014 at 11:43:54AM +0000, Lee Jones wrote:
> 
> > +Required properties:
> > +- compatible	: "st,comms-ssc-spi" or "st,comms-ssc4-spi"
> 
> What do the two different compatible strings mean (for example, should
> ssc4 be used for version 4 and higher or is it just a quirk for that
> version)?

This appears to be historical.  There aren't any functional
differences i.e. we don't match on them.  I believe the former is a
more informal, generic name and the latter is the official name of the
IP block.  The I2C component already upstreamed has the same naming
conventions by the looks of it.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
