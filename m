From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 23 Jun 2016 11:08:49 +0200
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add Sierra Wireless
In-Reply-To: <20160620162822.GA25662@rob-hp-laptop>
References: <1466160132-24574-1-git-send-email-narmstrong@baylibre.com>
 <1466160132-24574-2-git-send-email-narmstrong@baylibre.com>
 <20160620162822.GA25662@rob-hp-laptop>
Message-ID: <576BA721.8000408@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2016 06:28 PM, Rob Herring wrote:
> On Fri, Jun 17, 2016 at 12:42:09PM +0200, Neil Armstrong wrote:
>> Add Sierra Wireless as swi vendor prefix.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 2c2500d..45bccd2 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -250,6 +250,7 @@ st	STMicroelectronics
>>  startek	Startek
>>  ste	ST-Ericsson
>>  stericsson	ST-Ericsson
>> +swi	Sierra Wireless
> 
> Can we use the stock ticker 'swir' here.
> 
>>  syna	Synaptics Inc.
>>  synology	Synology, Inc.
>>  SUNW	Sun Microsystems, Inc

Hi Rob,

They already use a lot the "swi" prefix for all their open source platform and SDK.

It would be simpler to stick to "swi".

Neil
