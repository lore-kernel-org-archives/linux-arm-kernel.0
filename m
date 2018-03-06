From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Tue, 06 Mar 2018 10:32:45 +0800
Subject: [RESEND PATCH v6 09/14] dt-bindings: iommu/rockchip: Add clock
 property
In-Reply-To: <20180306022742.yfx2ond45orzhqiy@rob-hp-laptop>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
 <20180301101837.27969-10-jeffy.chen@rock-chips.com>
 <20180306022742.yfx2ond45orzhqiy@rob-hp-laptop>
Message-ID: <5A9DFDCD.7040107@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for your reply.

On 03/06/2018 10:27 AM, Rob Herring wrote:
> On Thu, Mar 01, 2018 at 06:18:32PM +0800, Jeffy Chen wrote:
>> Add clock property, since we are going to control clocks in rockchip
>> iommu driver.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v6: None
>
> Really? There was a different number of clocks before.
hmm, right, forgot to modify the change log, sorry...
>
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
>
>
