From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 29 Nov 2013 17:35:28 +0200
Subject: [PATCH 1/2] memory: ti-aemif: introduce AEMIF driver
In-Reply-To: <5298B370.3090405@ti.com>
References: <1384962416-14862-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1384962416-14862-2-git-send-email-ivan.khoronzhuk@ti.com>
 <5298B370.3090405@ti.com>
Message-ID: <5298B440.1020905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 05:32 PM, Santosh Shilimkar wrote:
> On Wednesday 20 November 2013 10:46 AM, Ivan Khoronzhuk wrote:
>> Add new AEMIF driver for EMIF16 Texas Instruments controller.
>> The EMIF16 module is intended to provide a glue-less interface to
>> a variety of asynchronous memory devices like ASRA M, NOR and NAND
>> memory. A total of 256M bytes of any of these memories can be
>> accessed at any given time via four chip selects with 64M byte access

[...]

>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id aemif_of_match[] = {
>> +	{ .compatible = "ti,davinci-aemif", },
>> +	{ .compatible = "ti,keystone-aemif", },
>> +	{ .compatible = "ti,omap-L138-aemif", },
>> +	{},
>> +};
>> +
> Looks like you are yet to update the patches from
> previous comments. Did I miss v2 or you haven't posted
> that yet ?

No. This is v2, actually :( (the mess was already noticed) it was posted 
after v1 (https://lkml.org/lkml/2013/11/11/352), but people continue 
commenting v1, for some reasons.

Next version will be posted when bindings will be clarified finally.

Regards,
-grygorii
