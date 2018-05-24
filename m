From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 24 May 2018 09:22:48 +0200
Subject: [PATCH V4 0/8] net: ethernet: stmmac: add support for stm32mp1
In-Reply-To: <20180523.160811.1425159248399846750.davem@davemloft.net>
References: <1527090479-5263-1-git-send-email-christophe.roullier@st.com>
 <20180523.160811.1425159248399846750.davem@davemloft.net>
Message-ID: <d04d3859-0b0c-5328-82b3-23591021b62a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/23/2018 10:08 PM, David Miller wrote:
> From: Christophe Roullier <christophe.roullier@st.com>
> Date: Wed, 23 May 2018 17:47:51 +0200
> 
>> Patches to have Ethernet support on stm32mp1
>> Changelog:
>> Remark from Rob Herring
>> Move Documentation/devicetree/bindings/arm/stm32.txt in
>> Documentation/devicetree/bindings/arm/stm32/stm32.txt and create
>> Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
>>
>> Replace also in arch/arm/boot/dts/stm32mp157c.dtsi, syscfg: system-config at 50020000
>> with syscfg: syscon at 50020000syscfg: system-config at 50020000
> 
> Probably the DTS file updates need to go in via the ARM tree, not
> mine.

Yes I will take them in my tree

> 
> Can you respin a net-next targetted series that has just the driver
> code and device tree binding updates?
> 
> Thank you!
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
