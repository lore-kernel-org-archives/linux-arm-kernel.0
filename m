From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 2 Dec 2011 13:29:13 +0100
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <20111202122558.GM8245@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111202122558.GM8245@opensource.wolfsonmicro.com>
Message-ID: <4ED8C499.2080002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/2/2011 1:25 PM, Mark Brown wrote:
> On Fri, Dec 02, 2011 at 11:52:56AM +0200, Peter Ujfalusi wrote:
>
>> +Required properties:
>> +  - compatible : "ti,omap4-dmic"
>> +  - ti,hwmods  : List of hwmod names associated with DMIC, in most case
>> +		 it is "dmic".
>
> Shouldn't there also be a regs property giving the register window?

Not for the moment, because we are still using the hwmod database to 
retrieve the base address + irq + dma.

I need to have the support for resource name before replacing the hwmod 
data by a real "reg" + "reg-names" attributes.

I'll send a series with that ASAP.

Regards,
Benoit
