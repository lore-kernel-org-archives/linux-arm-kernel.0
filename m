From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 29 Jun 2018 16:36:43 +0200
Subject: [PATCH 3/3] arm64: dts: marvell: armada-37xx: add the node
 allowing AVS support
In-Reply-To: <20180629095426.7aein2vmjtegyrfa@vireshk-i7> (Viresh Kumar's
 message of "Fri, 29 Jun 2018 15:24:26 +0530")
References: <20180619124402.902-1-gregory.clement@bootlin.com>
 <20180619124402.902-4-gregory.clement@bootlin.com>
 <20180629095426.7aein2vmjtegyrfa@vireshk-i7>
Message-ID: <87602164n8.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,
 
 On ven., juin 29 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 19-06-18, 14:44, Gregory CLEMENT wrote:
>> In order to be able to use Adaptive Voltage Scaling, we need to add a
>> reference to these registers.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks! Based on your acked-by, then I applied this patch on mvebu/dt

I let you apply the 2 other patches of the series

Gregory



>
> -- 
> viresh

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
