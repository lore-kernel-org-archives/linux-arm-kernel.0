From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat, 20 Aug 2016 20:11:46 +0200
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add Sierra Wireless
In-Reply-To: <20160819134846.GA2414@rob-hp-laptop>
References: <1471525881-2797-1-git-send-email-narmstrong@baylibre.com>
 <1471525881-2797-2-git-send-email-narmstrong@baylibre.com>
 <20160819134846.GA2414@rob-hp-laptop>
Message-ID: <f66ef46c-bfb9-795f-12d8-77a91811ecf5@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2016 03:48 PM, Rob Herring wrote:
> On Thu, Aug 18, 2016 at 03:11:18PM +0200, Neil Armstrong wrote:
>> Add Sierra Wireless as swi vendor prefix.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 1992aa9..5a8881f 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -254,6 +254,7 @@ starry	Starry Electronic Technology (ShenZhen) Co., LTD
>>  startek	Startek
>>  ste	ST-Ericsson
>>  stericsson	ST-Ericsson
>> +swi	Sierra Wireless
> 
> swir is the stock ticker. Can you use that?

I hoped to use swi since they use is a lot, bet swir is indeed more coherent.

> 
> This is going to have some conflicts with some sorting fixes, so I plan 
> to pick up this patch separately.

OK/\.

> 
> Rob
> 
Thanks,
Neil
