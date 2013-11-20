From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Wed, 20 Nov 2013 22:38:46 +0200
Subject: [PATCH 0/3] Reuse davinci-nand driver for Keystone arch
In-Reply-To: <528D1C94.7010100@ti.com>
References: <1384964699-15134-1-git-send-email-ivan.khoronzhuk@ti.com>
 <528D18EC.6000501@ti.com> <528D1C94.7010100@ti.com>
Message-ID: <528D1DD6.9010808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 10:33 PM, Santosh Shilimkar wrote:
> On Wednesday 20 November 2013 03:17 PM, Grygorii Strashko wrote:
>> On 11/20/2013 06:24 PM, Ivan Khoronzhuk wrote:
>>> This series contains updates of Davinci nand driver, in order to be
>>> reused for Keystone platform.
>>>
>>> Depends on:
>>> - Davinci nand driver fixes and updates:
>>>     https://lkml.org/lkml/2013/11/20/271
>>
>> ^^^^ I suggest to merge this series with above one as it
>> should not break anything.
>>
> I agree. That way the mtd patch series can go
> together nicely.
>
> Regards,
> Santosh
>

Ok, I will combine them

-- 
Regards,
Ivan Khoronzhuk
