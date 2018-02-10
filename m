From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Sat, 10 Feb 2018 10:45:35 +0200
Subject: [PATCH v2 4/7] dt-bindings: tegra: Add missing chips and NVIDIA
 boards
In-Reply-To: <20180209224922.4fxlpl77kwibzfui@rob-hp-laptop>
References: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
 <1517901757-15353-5-git-send-email-mperttunen@nvidia.com>
 <20180209224922.4fxlpl77kwibzfui@rob-hp-laptop>
Message-ID: <5105d996-8020-ebcf-cf46-2f13c6b8b35f@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2018 12:49 AM, Rob Herring wrote:
> On Tue, Feb 06, 2018 at 09:22:34AM +0200, Mikko Perttunen wrote:
>> Add compatibility strings for supported but undocumented Tegra chips
>> (Tegra114/124/132/210/186/194) and reference boards.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>
>> Notes:
>>      v2:
>>      - add patch
>>
>>   Documentation/devicetree/bindings/arm/tegra.txt | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
>> index 7f1411bbabf7..32f62bb7006d 100644
>> --- a/Documentation/devicetree/bindings/arm/tegra.txt
>> +++ b/Documentation/devicetree/bindings/arm/tegra.txt
>> @@ -9,6 +9,12 @@ following compatible values:
>>   
>>     nvidia,tegra20
>>     nvidia,tegra30
>> +  nvidia,tegra114
>> +  nvidia,tegra124
>> +  nvidia,tegra132
>> +  nvidia,tegra210
> 
> Some reason why this is not in numerical order?

They are in chronological/chip generation order, and for whatever 
reason, that isn't numerical.

Mikko

> 
>> +  nvidia,tegra186
>> +  nvidia,tegra194
>>   
>>   Boards
>>   -------------------------------------------
>> @@ -26,8 +32,18 @@ board-specific compatible values:
>>     nvidia,cardhu
>>     nvidia,cardhu-a02
>>     nvidia,cardhu-a04
>> +  nvidia,dalmore
>>     nvidia,harmony
>> +  nvidia,jetson-tk1
>> +  nvidia,norrin
>> +  nvidia,p2371-0000
>> +  nvidia,p2371-2180
>> +  nvidia,p2571
>> +  nvidia,p2771-0000
>> +  nvidia,p2972-0000
>> +  nvidia,roth
>>     nvidia,seaboard
>> +  nvidia,tn7
>>     nvidia,ventana
>>     toradex,apalis_t30
>>     toradex,apalis_t30-eval
>> -- 
>> 2.1.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
