From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 9 Jun 2014 09:59:03 -0400
Subject: [PATCH] dt/documentation: add specification of dma bus information
In-Reply-To: <CAOMZO5Ceg9RpC8Lgt0BwGTuaz-Z2614Die2PrbtT_j4QYjL_sA@mail.gmail.com>
References: <1401981720-6946-1-git-send-email-santosh.shilimkar@ti.com>
 <CAOMZO5Ceg9RpC8Lgt0BwGTuaz-Z2614Die2PrbtT_j4QYjL_sA@mail.gmail.com>
Message-ID: <5395BDA7.3060507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 June 2014 10:13 PM, Fabio Estevam wrote:
> On Thu, Jun 5, 2014 at 12:22 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Recently we introduced the generic device tree infrastructure for couple of DMA
>> bus parameter, dma-ranges and dma-coherent. Update the documentation so that
>> its useful for future users.
>>
>> The "dma-ranges" property is intended to be used for describing the
>> configuration of DMA bus RAM addresses and its offset w.r.t CPU addresses.
>>
>> The "dma-coherent" property is intended to be used for identifying devices
>> supported coherent DMA operations.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Cc: Shawn Guo <shawn.guo@freescale.com>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  Documentation/devicetree/booting-without-of.txt |   60 +++++++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>
>> diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
>> index 1f013bd..f0120c1 100644
>> --- a/Documentation/devicetree/booting-without-of.txt
>> +++ b/Documentation/devicetree/booting-without-of.txt
>> @@ -51,6 +51,8 @@ Table of Contents
>>
>>    VIII - Specifying device power management information (sleep property)
>>
>> +  VIV - Specifying dma bus information
> 
> "9" in Roman numeral is "IX"
> 
Yeah.. Not sure what I was thinking...

Regards,
Santosh
