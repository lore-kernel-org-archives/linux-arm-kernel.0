From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 02 Dec 2011 14:32:59 +0200
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <20111202122558.GM8245@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111202122558.GM8245@opensource.wolfsonmicro.com>
Message-ID: <4ED8C57B.2000503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2011 02:25 PM, Mark Brown wrote:
> On Fri, Dec 02, 2011 at 11:52:56AM +0200, Peter Ujfalusi wrote:
> 
>> +Required properties:
>> +  - compatible : "ti,omap4-dmic"
>> +  - ti,hwmods  : List of hwmod names associated with DMIC, in most case
>> +		 it is "dmic".
> 
> Shouldn't there also be a regs property giving the register window?

As of now we receive all these information via OMAP hwmod.
All the properties (addresses, irq, etc) of the HW IP will be coming
from DT as soon as I can remove the ti,hwmod property.

-- 
P?ter
