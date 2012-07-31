From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 15:59:46 +0100
Subject: [PATCH 18/19] Documentation: Define the MSP Driver Device Tree
 bindings
In-Reply-To: <20120731135539.GO4468@opensource.wolfsonmicro.com>
References: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
 <1343741953-17828-19-git-send-email-lee.jones@linaro.org>
 <20120731135539.GO4468@opensource.wolfsonmicro.com>
Message-ID: <5017F2E2.4040100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 14:55, Mark Brown wrote:
> On Tue, Jul 31, 2012 at 02:39:12PM +0100, Lee Jones wrote:
>
>> +Optional properties:
>> + - interrupts       : The interrupt outputs from the device.
>
> If there's more than one interrupt then how are they ordered?

It doesn't matter. If there are any more than one (which there aren't in 
this case), we usually use the interrupt-names property then request 
them by name in the driver.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
