From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 07 Feb 2018 17:44:31 +0100
Subject: [PATCH 1/2] ARM: dts: exynos: Add I2S1 device node to
 exynos5433.dtsi
In-Reply-To: <CAJKOXPdxND9Rf4p6stkdhBNY0AzdMqfDtopiBfYttex77+tjnA@mail.gmail.com>
References: <CGME20180205172146epcas1p1cd7a5027e673fc17fb64d8841c47175a@epcas1p1.samsung.com>
 <20180205172110.9897-1-s.nawrocki@samsung.com>
 <CAJKOXPdxND9Rf4p6stkdhBNY0AzdMqfDtopiBfYttex77+tjnA@mail.gmail.com>
Message-ID: <04ddb780-ae65-1967-d75f-844a675cd3da@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2018 02:07 PM, Krzysztof Kozlowski wrote:
> On Mon, Feb 5, 2018 at 6:21 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> Add DT node for the second I2S controller available on Exynos 5433
>> SoC. While at it the i2s0 node name is changed to a more generic
>> "i2s" and missing properties are added to that node.
>
> Please split it - one patch for adding new I2S and second minor
> cleanup in i2s0 and adding of required properties.

OK, will split it in next iteration.
 
> I think there are no dependencies on driver code changes... but let me
> know if I am wrong.

Yes, the dts and driver changes are independent, it should work
in all combinations: old dts/new driver, new dts/new driver,
new dts/old driver.

--
Regards,
Sylwester
