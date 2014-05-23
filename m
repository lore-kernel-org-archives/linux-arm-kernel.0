From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Sat, 24 May 2014 00:38:59 +0300
Subject: [Patch v7 0/7] Introduce keystone reset driver
In-Reply-To: <537FBD6A.9040308@ti.com>
References: <1400859812-5761-1-git-send-email-ivan.khoronzhuk@ti.com>
 <537FBD6A.9040308@ti.com>
Message-ID: <537FBFF3.7040608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/24/2014 12:28 AM, Santosh Shilimkar wrote:
> On Friday 23 May 2014 11:43 AM, Ivan Khoronzhuk wrote:
>> These patches introduce keystone reset driver.
>>
>> The keystone SoC can be rebooted in several ways. By external reset
>> pin, by soft and by watchdogs. This driver allows software reset and reset
>> by one of the watchdogs. Also added opportunity to set soft/hard reset type.
>>
>> Based on linux-next/master
>>
>> v7..v6
>>    power: reset: keystone-reset: introduce keystone reset driver
>>    power: reset: add bindings for keystone reset driver
>>    ARM: dts: keystone: update reset node to work with reset driver
>> 	- s/wdt_list/wdt-list/g
>>
> I dropped patch 3/7 since its already queued up in mfd tree. Rest
> of the patches with minor commit edits queued for 3.16. Pull request
> to follow.
>
> Regards,
> Santosh

Thanks.

-- 
Regards,
Ivan Khoronzhuk
