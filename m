From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 8 May 2014 23:26:29 +0300
Subject: [PATCH] ARM: dts: k2e-evm: add AEMIF/NAND device entry
In-Reply-To: <536BD85E.8090505@ti.com>
References: <1399575560-31090-1-git-send-email-ivan.khoronzhuk@ti.com>
 <536BD85E.8090505@ti.com>
Message-ID: <536BE875.2070005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/08/2014 10:17 PM, Santosh Shilimkar wrote:
> On Thursday 08 May 2014 02:59 PM, Ivan Khoronzhuk wrote:
>> Add AEMIF/NAND device entry.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>> ---
>>   arch/arm/boot/dts/k2e-evm.dts | 52 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
> Thanks. Will pick this up for 3.16
>

Ups. Seems I've not changed ubifs partition size, always think about 128 
Mb, but here 512 Mb.
I will send updated version with correct partition size.


-- 
Regards,
Ivan Khoronzhuk
