From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 19 Jun 2017 14:00:08 +0100
Subject: [PATCH v3 19/21] dt-bindings: mmc: dw_mmc-k3: add document of
 hi3660 mmc
In-Reply-To: <CAPDyKFpvJu8_TETWr0Vy4ubDC7NYvi7TxmSLYZyw33qHFsoNaQ@mail.gmail.com>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
 <20170614082338.15673-20-guodong.xu@linaro.org>
 <CAPDyKFpvJu8_TETWr0Vy4ubDC7NYvi7TxmSLYZyw33qHFsoNaQ@mail.gmail.com>
Message-ID: <5947CAD8.4040607@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On 2017/6/19 13:43, Ulf Hansson wrote:
> On 14 June 2017 at 10:23, Guodong Xu <guodong.xu@linaro.org> wrote:
>> Add bindings for hi3660 mmc support
>>
>> Signed-off-by: Li Wei <liwei213@huawei.com>
>> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> index df37058..8af1afc 100644
>> --- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> @@ -12,6 +12,7 @@ extensions to the Synopsys Designware Mobile Storage Host Controller.
>>  Required Properties:
>>
>>  * compatible: should be one of the following.
>> +  - "hisilicon,hi3660-dw-mshc": for controllers with hi3660 specific extensions.
>>    - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extensions.
>>    - "hisilicon,hi6220-dw-mshc": for controllers with hi6220 specific extensions.
>>
>> --
>> 2.10.2
>>
> 
> Thanks, applied for next!

Thanks!
Last week I had applied the v4 patch set[1]
and this patch is included.
But it should be fine for the upper gatekeeper to merge
since these 2 patch are same.

[1]:https://lkml.org/lkml/2017/6/14/1053

Best Regards,
Wei

> 
> Kind regards
> Uffe
> 
> .
> 
