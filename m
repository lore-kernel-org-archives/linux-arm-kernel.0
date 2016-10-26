From: tthayer@opensource.altera.com (Thor Thayer)
Date: Wed, 26 Oct 2016 10:18:32 -0500
Subject: [PATCH 3/4] mfd: altr-a10sr: Add Arria10 SR Monitor
In-Reply-To: <20161026125233.GL11267@dell>
References: <1476394329-31696-1-git-send-email-tthayer@opensource.altera.com>
 <1476394329-31696-4-git-send-email-tthayer@opensource.altera.com>
 <20161026125233.GL11267@dell>
Message-ID: <f85a537e-716f-cc40-a47a-0f2345526fef@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/26/2016 07:52 AM, Lee Jones wrote:
> On Thu, 13 Oct 2016, tthayer at opensource.altera.com wrote:
>
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Add the Altera Arria10 DevKit System Resource Monitor functionality
>> to the MFD device.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>>  drivers/mfd/altera-a10sr.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mfd/altera-a10sr.c b/drivers/mfd/altera-a10sr.c
>> index 06e1f7f..0942d7d 100644
>> --- a/drivers/mfd/altera-a10sr.c
>> +++ b/drivers/mfd/altera-a10sr.c
>> @@ -33,6 +33,10 @@
>>  		.name = "altr_a10sr_gpio",
>>  		.of_compatible = "altr,a10sr-gpio",
>>  	},
>> +	{
>> +		.name = "altr_a10sr_mon",
>> +		.of_compatible = "altr,a10sr-mon",
>
> "-monitor" would be better in my opinion.
>

OK. I'm flexible and it is clearer. I'll make the changes and resubmit.
Thanks for reviewing!

>> +	},
>>  };
>>
>>  static bool altr_a10sr_reg_readable(struct device *dev, unsigned int reg)
>
