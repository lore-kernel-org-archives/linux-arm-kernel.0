From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 16 Sep 2013 08:34:00 +0530
Subject: [PATCH 4/7] Documentation: dt bindings: move ..usb/usb-phy.txt
 to ..phy/omap-phy.txt
In-Reply-To: <5231C040.4040609@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
 <1378136591-7463-5-git-send-email-kishon@ti.com> <5231C040.4040609@ti.com>
Message-ID: <52367520.8010909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 September 2013 06:53 PM, Roger Quadros wrote:
> On 09/02/2013 06:43 PM, Kishon Vijay Abraham I wrote:
>> Since now we have a separate folder for phy, move the PHY dt binding
>> documentation of OMAP to that folder.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   .../devicetree/bindings/{usb/usb-phy.txt => phy/omap-phy.txt}        |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>   rename Documentation/devicetree/bindings/{usb/usb-phy.txt => phy/omap-phy.txt} (96%)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/phy/omap-phy.txt
>> similarity index 96%
>> rename from Documentation/devicetree/bindings/usb/usb-phy.txt
>> rename to Documentation/devicetree/bindings/phy/omap-phy.txt
>> index 36bdb17..2c485ee 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/omap-phy.txt
>
> ti-phy.txt?

maybe wait for that later?

Thanks
Kishon
