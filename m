From: marex@denx.de (Marek Vasut)
Date: Mon, 29 Aug 2016 15:45:47 +0200
Subject: [PATCH] ARM: dts: imx6sx: Add GPU bindings
In-Reply-To: <20160829134100.GO30790@tiger>
References: <20160826142254.6950-1-marex@denx.de>
 <20160829134100.GO30790@tiger>
Message-ID: <d65711de-d225-8229-4dfd-399a4fe92289@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2016 03:41 PM, Shawn Guo wrote:
> On Fri, Aug 26, 2016 at 04:22:54PM +0200, Marek Vasut wrote:
>> Add bindings for the Vivante GC400T GPU found in the i.MX6SX .
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> ---
>>  arch/arm/boot/dts/imx6sx.dtsi | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
>> index 6a993bfda..901c2d2 100644
>> --- a/arch/arm/boot/dts/imx6sx.dtsi
>> +++ b/arch/arm/boot/dts/imx6sx.dtsi
>> @@ -1250,6 +1250,16 @@
>>  			};
>>  		};
>>  
>> +		gpu: gpu at 01800000 {
> 
> Wrong place for the node.  It should go right before dma-apbh at 01804000.
> I fixed it up and applied patch.

Thanks!

> Shawn

[..]

-- 
Best regards,
Marek Vasut
