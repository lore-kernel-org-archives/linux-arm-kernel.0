From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 23 May 2018 16:51:12 -0700
Subject: [PATCH v2 2/6] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
In-Reply-To: <20180523222915.GA16779@roeck-us.net>
References: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
 <1527107527-8093-3-git-send-email-ray.jui@broadcom.com>
 <20180523222915.GA16779@roeck-us.net>
Message-ID: <48dfe138-7bf5-3f91-0108-5b0ce3811ab7@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/23/2018 3:29 PM, Guenter Roeck wrote:
> On Wed, May 23, 2018 at 01:32:03PM -0700, Ray Jui wrote:
>> Update the SP805 binding document to add optional 'timeout-sec'
>> devicetree property
>>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   Documentation/devicetree/bindings/watchdog/arm,sp805.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
>> index de93a4d..9cd7470 100644
>> --- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
>> @@ -18,6 +18,8 @@ Required properties:
>>   
>>   Optional properties:
>>   - interrupts : Should specify WDT interrupt number.
>> +timeout-sec : Should specify default WDT timeout in seconds. If unset, the
>> +              default timeout in the driver is 30 seconds
> 
> That looks odd, with the changed indentation and the missing '-'
> in front of 'timeout-sec' >

My bad. Will fix this in v3. Thanks.

> Guenter
> 
