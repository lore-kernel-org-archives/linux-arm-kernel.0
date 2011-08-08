From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 08 Aug 2011 20:59:27 +0100
Subject: [RFC PATCH 2/2] AT91: dt: simple device tree support for
	at91sam9g45 family
In-Reply-To: <20110807035751.GC7667@ponder.secretlab.ca>
References: <56092075210001f40db485e0b126fe7c0c7b75ac.1312560476.git.nicolas.ferre@atmel.com>
	<bdd7c02a561bc0655e9dfd4586f42774f2347ca1.1312560476.git.nicolas.ferre@atmel.com>
	<20110807035751.GC7667@ponder.secretlab.ca>
Message-ID: <4E40401F.4030309@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2011 04:57 AM, Grant Likely wrote:
> On Fri, Aug 05, 2011 at 05:24:53PM +0100, Nicolas Ferre wrote:
>> Add basic device tree support for at91sam9g45 SoC family and the
>> at91sam9m10g45ek board.
>> DT is been used to describe the at91sam9g45 SoC memory and AIC. It also
>> adds the dmaengine driver.
>>
>> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
>
> Hi Nicolas,
>
> Looks like a great start.  I was glad we could work on this last week.

Yes, that was enriching.

> Some comments below.

I will have to rework this series for sure but I have limited access to 
my git tree/emails this week... I plan to come back to this next week.

>> ---
>>   arch/arm/mach-at91/Kconfig               |    8 ++++++
>>   arch/arm/mach-at91/Makefile.boot         |    2 +
>>   arch/arm/mach-at91/at91sam9g45_devices.c |    3 +-
>>   arch/arm/mach-at91/board-sam9m10g45ek.c  |   36 ++++++++++++++++++++++++++++++
>>   4 files changed, 48 insertions(+), 1 deletions(-)

[..]

Best regards,
-- 
Nicolas Ferre
