From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 28 Jun 2013 10:45:58 +0530
Subject: [PATCH v9 1/8] drivers: phy: add generic PHY framework
In-Reply-To: <000d01ce73af$62a95a60$27fc0f20$@samsung.com>
References: <000d01ce73af$62a95a60$27fc0f20$@samsung.com>
Message-ID: <51CD1C0E.5030000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 June 2013 08:57 AM, Jingoo Han wrote:
> On Wed, 26 Jun 2013 17:17:29 +0530, Kishon Vijay Abraham Iwrote:
>> The PHY framework provides a set of APIs for the PHY drivers to
>> create/destroy a PHY and APIs for the PHY users to obtain a reference to the
>> PHY with or without using phandle. For dt-boot, the PHY drivers should
>> also register *PHY provider* with the framework.
>>
>> PHY drivers should create the PHY by passing id and ops like init, exit,
>> power_on and power_off. This framework is also pm runtime enabled.
>>
>> The documentation for the generic PHY framework is added in
>> Documentation/phy.txt and the documentation for dt binding can be found at
>> Documentation/devicetree/bindings/phy/phy-bindings.txt
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> Tested-by: Jingoo Han <jg1.han@samsung.com>
>
> It looks great to me!
>
> I tested this General PHY framework with Exynos5250 eDP.
> It works properly.

Thanks for testing this :-)

> I will share the patch 'Generic PHY driver for the Exynos SoC DP PHY', soon.
> Thanks.

Cool.

Thanks
Kishon
