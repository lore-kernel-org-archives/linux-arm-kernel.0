From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 May 2014 17:21:30 -0400
Subject: [PATCH] ARM: dts: k2e-evm: add AEMIF/NAND device entry
In-Reply-To: <536BE875.2070005@ti.com>
References: <1399575560-31090-1-git-send-email-ivan.khoronzhuk@ti.com>
 <536BD85E.8090505@ti.com> <536BE875.2070005@ti.com>
Message-ID: <536BF55A.6030406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 May 2014 04:26 PM, Ivan Khoronzhuk wrote:
> 
> On 05/08/2014 10:17 PM, Santosh Shilimkar wrote:
>> On Thursday 08 May 2014 02:59 PM, Ivan Khoronzhuk wrote:
>>> Add AEMIF/NAND device entry.
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>>> ---
>>>   arch/arm/boot/dts/k2e-evm.dts | 52 +++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 52 insertions(+)
>>>
>> Thanks. Will pick this up for 3.16
>>
> 
> Ups. Seems I've not changed ubifs partition size, always think about 128 Mb, but here 512 Mb.
> I will send updated version with correct partition size.
> 
> 
I was about to reply that patch wasn't applying cleanly. V2 applied
to for_3.16/dts branch.

Can you also rebase the ke2 patch against the dts branch and
repost it ?

Thanks !!

regards,
Santosh
