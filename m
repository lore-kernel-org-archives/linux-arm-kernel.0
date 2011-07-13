From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 13 Jul 2011 16:40:58 +0400
Subject: [PATCH 3.1 3/4] ARM:simpad: add GPIO based device definitions.
In-Reply-To: <4E1D91CB.6090405@scram.de>
References: <1310453186-22518-1-git-send-email-jochen@scram.de>	<1310453186-22518-4-git-send-email-jochen@scram.de>
	<ivgta2$vvj$1@dough.gmane.org> <4E1D91CB.6090405@scram.de>
Message-ID: <4E1D925A.9050601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 13.07.2011 16:38, Jochen Friedrich wrote:
> Hi Dmitry,
>
>>> @@ -259,7 +321,10 @@ static struct platform_device simpad_mq200fb = {
>>> };
>>>
>>> static struct platform_device *devices[] __initdata = {
>>> - &simpad_mq200fb
>>
>> Are you sure this is correct?
>>
>>> + &simpad_keys,
>>> + &simpad_polled_keys,
>>> + &simpad_mq200fb,
>>> + &simpad_i2c,
>>> };
>
> Sorry, I don't see your point here. Could you clarify? Did I miss
> something obvious?

Oh, I'm sorry now. I saw the removal of mq200fb device, but missed the 
re-addition of it. So please ignore my comment.

-- 
With best wishes
Dmitry
