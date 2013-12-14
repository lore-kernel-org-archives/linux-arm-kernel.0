From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 14 Dec 2013 14:18:36 -0500
Subject: [PATCH v3 0/9] Reuse davinci-nand driver for Keystone arch
In-Reply-To: <52A5F355.9020704@ti.com>
References: <1386264358-9738-1-git-send-email-ivan.khoronzhuk@ti.com>
 <52A5F355.9020704@ti.com>
Message-ID: <52ACAF0C.6060205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 December 2013 11:44 AM, Santosh Shilimkar wrote:
> David,
> 
> On Thursday 05 December 2013 12:25 PM, Ivan Khoronzhuk wrote:
>> This series contains fixes and updates of Davinci nand driver in
>> order to reuse it for Keystone platform.
>>
>> v2..v3:
>> - mtd: nand: davinci: don't set timings if AEMIF is used
>> 	dropped, it would be replaced by alone patch
>> 	ARM: davinci: aemif: get rid of davinci-nand driver dependency on aemif
>>
>> v1..v2
>> The series is combination of two following series:
>> - Davinci nand driver fixes and updates:
>> https://lkml.org/lkml/2013/11/20/271
>> - Reuse davinci-nand driver for Keystone arch
>> https://lkml.org/lkml/2013/11/20/315
>>
>> - mtd: nand: davinci: extend description of bindings
>> 	clarified changeset description
>>
>> - mtd: nand: davinci: reuse driver for Keystone arch
>> 	removed "ti,keystone-nand" compatible from driver
>>
>> Ivan Khoronzhuk (9):
>>   mtd: nand: davinci: fix driver registration
>>   mtd: nand: davinci: return ENOMEM if memory allocation is failed
>>   mtd: nand: davinci: check required ti,davinci-chipselect property
>>   mtd: nand: davinci: simplify error handling
>>   mtd: nand: davinci: move bindings under mtd
>>   mtd: nand: davinci: extend description of bindings
>>   mtd: nand: davinci: adjust DT properties to MTD generic
>>   mtd: nand: davinci: reuse driver for Keystone arch
>>   mtd: nand: davinci: don't request AEMIF address range
>>
> Can you please pick up the $subject series if you are happy
> with it ?
> It lets us re-use Davinci nand driver on Keystone SOCs.
> 
Ping..

regards,
Santosh
