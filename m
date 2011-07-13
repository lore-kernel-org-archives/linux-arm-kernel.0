From: jochen@scram.de (Jochen Friedrich)
Date: Wed, 13 Jul 2011 14:38:35 +0200
Subject: [PATCH 3.1 3/4] ARM:simpad: add GPIO based device definitions.
In-Reply-To: <ivgta2$vvj$1@dough.gmane.org>
References: <1310453186-22518-1-git-send-email-jochen@scram.de>	<1310453186-22518-4-git-send-email-jochen@scram.de>
	<ivgta2$vvj$1@dough.gmane.org>
Message-ID: <4E1D91CB.6090405@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

>> @@ -259,7 +321,10 @@ static struct platform_device simpad_mq200fb = {
>>   };
>>
>>   static struct platform_device *devices[] __initdata = {
>> -	&simpad_mq200fb
>
> Are you sure this is correct?
>
>> +	&simpad_keys,
>> +	&simpad_polled_keys,
>> +	&simpad_mq200fb,
>> +	&simpad_i2c,
>>   };

Sorry, I don't see your point here. Could you clarify? Did I miss 
something obvious?

Thanks,
Jochen
