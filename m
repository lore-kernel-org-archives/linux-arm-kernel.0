From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 12 Mar 2018 10:23:29 +0900
Subject: [PATCH v2] dt-bindings: exynos: Document #sound-dai-cells
 property of the HDMI node
In-Reply-To: <20180309230225.i2ytunejt2sotsrc@rob-hp-laptop>
References: <CGME20180309154029epcas1p280472548d1aa86daafceb405b10f1589@epcas1p2.samsung.com>
 <20180309154016.15562-1-s.nawrocki@samsung.com>
 <20180309230225.i2ytunejt2sotsrc@rob-hp-laptop>
Message-ID: <5AA5D691.2070007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2018? 03? 10? 08:02? Rob Herring ?(?) ? ?:
> On Fri, Mar 09, 2018 at 04:40:16PM +0100, Sylwester Nawrocki wrote:
>> The #sound-dai-cells DT property is required to describe link between
>> the HDMI IP block and the SoC's audio subsystem.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>> Changes since v2:
>>  - the property has been moved to "Required properties" paragraph,
>>    I didn't add Rob's Reviewed-by due to this change
>> ---
>>  Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt | 1 +
>>  1 file changed, 1 insertion(+)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Inki Dae

> 
> 
> 
> 
