From: marex@denx.de (Marek Vasut)
Date: Sun, 23 Oct 2016 15:30:32 +0200
Subject: [PATCH 1/4] ARM: dts: mxs: Add new M28EVK manufacturer compat
In-Reply-To: <20161023130143.GT30578@tiger>
References: <20160919214044.9615-1-marex@denx.de>
 <20161023130143.GT30578@tiger>
Message-ID: <3ec3e368-c8f1-3bee-7b7b-6de5cef72325@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2016 03:01 PM, Shawn Guo wrote:
> On Mon, Sep 19, 2016 at 11:40:41PM +0200, Marek Vasut wrote:
>> The board is now manufactured by Aries Embedded GmbH, update compat string.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> ---
>>  arch/arm/boot/dts/imx28-m28.dtsi   | 4 ++--
>>  arch/arm/boot/dts/imx28-m28evk.dts | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
>> index 214bb15..a69856e 100644
>> --- a/arch/arm/boot/dts/imx28-m28.dtsi
>> +++ b/arch/arm/boot/dts/imx28-m28.dtsi
>> @@ -12,8 +12,8 @@
>>  #include "imx28.dtsi"
>>  
>>  / {
>> -	model = "DENX M28";
>> -	compatible = "denx,m28", "fsl,imx28";
>> +	model = "Aries/DENX M28";
>> +	compatible = "aries,m28", "denx,m28", "fsl,imx28";
> 
> Do we have an entry for Aries Embedded GmbH in vendor-prefixes.txt?

The patch was submitted, not yet applied though:
http://www.spinics.net/lists/arm-kernel/msg533000.html

-- 
Best regards,
Marek Vasut
