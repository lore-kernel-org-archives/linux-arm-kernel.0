From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 21 Mar 2012 11:45:45 +0100
Subject: [PATCH 0/6] AT91 drivers Kconfig cleanup
In-Reply-To: <7104123.IANagkT9hm@dtor-d630.eng.vmware.com>
References: <cover.1331826095.git.nicolas.ferre@atmel.com>
 <7104123.IANagkT9hm@dtor-d630.eng.vmware.com>
Message-ID: <4F69B159.5030101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2012 05:50 PM, Dmitry Torokhov :
> On Thursday, March 15, 2012 04:57:16 PM Nicolas Ferre wrote:
>> This is a series which deals with AT91 drivers Kconfig entries. Its goal is
>> to remove too restrictive dependencies on SoC names.
>> This will allow to add support for newer SoC seamlessly.
>>
>> One question remains: should I submit those patches through dedicated
>> sub-maintainer's git trees or can I queue the whole series in arm-soc?
> 
> I'm fine if you queue input piece through arm-soc.

Ok, good: I have "Acknowledgement" by several maintainers: so yes, I
will send this series via arm-soc.

Is this means that I can add your "Acked-by"?

Best regards,
-- 
Nicolas Ferre
