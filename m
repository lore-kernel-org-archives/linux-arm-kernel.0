From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 16:10:24 +0100
Subject: [PATCH 18/19] Documentation: Define the MSP Driver Device Tree
 bindings
In-Reply-To: <5017F2E2.4040100@linaro.org>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
 <1343741953-17828-19-git-send-email-lee.jones@linaro.org>
 <20120731135539.GO4468@opensource.wolfsonmicro.com>
 <5017F2E2.4040100@linaro.org>
Message-ID: <20120731151024.GA4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 03:59:46PM +0100, Lee Jones wrote:
> On 31/07/12 14:55, Mark Brown wrote:

> >>+Optional properties:
> >>+ - interrupts       : The interrupt outputs from the device.

> >If there's more than one interrupt then how are they ordered?

> It doesn't matter. If there are any more than one (which there
> aren't in this case), we usually use the interrupt-names property
> then request them by name in the driver.

So the binding therefore needs to say "The interrupt output from the
device" as there's only one output supported.  If we were using
interrupt-names then we'd need to document what the supported names are.
