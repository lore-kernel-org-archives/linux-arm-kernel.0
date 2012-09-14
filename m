From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 14 Sep 2012 12:20:45 -0500
Subject: [PATCH V5 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <201209141526.17791.arnd@arndb.de>
References: <1347635923-30166-1-git-send-email-jon-hunter@ti.com>
 <1347635923-30166-2-git-send-email-jon-hunter@ti.com>
 <201209141526.17791.arnd@arndb.de>
Message-ID: <5053676D.8020602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/14/2012 10:26 AM, Arnd Bergmann wrote:
> On Friday 14 September 2012, Jon Hunter wrote:
>>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Stephen Warren <swarren@nvidia.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Cc: Dan Williams <djbw@fb.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks for all this work, looks great!

Thanks!

> My final (tiny) comment on this:
> 
>> +2. A single read-write channel with two alternative dma controllers:
>> +
>> +	dmas = <&dma1 5
>> +		&dma2 7
>> +		&dma3 2>;
>> +	dma-names = "rx-tx", "rx-tx", "rx-tx"
> 
> *three* alternative dma controllers, not two.

Oops! I have been starring at this so long I can no longer see the wood
for the trees!

Jon
