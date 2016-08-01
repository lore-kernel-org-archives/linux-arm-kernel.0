From: Songjun.Wu@microchip.com (Wu, Songjun)
Date: Mon, 1 Aug 2016 09:23:11 +0800
Subject: [PATCH v7 2/2] [media] atmel-isc: DT binding for Image Sensor
 Controller driver
In-Reply-To: <20160729214454.GA21408@rob-hp-laptop>
References: <1469778856-24253-1-git-send-email-songjun.wu@microchip.com>
 <1469778856-24253-3-git-send-email-songjun.wu@microchip.com>
 <20160729214454.GA21408@rob-hp-laptop>
Message-ID: <5a2cea98-dd8a-159b-7adb-a2533cfde1b0@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/30/2016 05:44, Rob Herring wrote:
> On Fri, Jul 29, 2016 at 03:54:08PM +0800, Songjun Wu wrote:
>> DT binding documentation for ISC driver.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@microchip.com>
>> ---
>>
>> Changes in v7: None
>> Changes in v6:
>> - Add "iscck" and "gck" to clock-names.
>>
>> Changes in v5:
>> - Add clock-output-names.
>>
>> Changes in v4:
>> - Remove the isc clock nodes.
>>
>> Changes in v3:
>> - Remove the 'atmel,sensor-preferred'.
>> - Modify the isc clock node according to the Rob's remarks.
>>
>> Changes in v2:
>> - Remove the unit address of the endpoint.
>> - Add the unit address to the clock node.
>> - Avoid using underscores in node names.
>> - Drop the "0x" in the unit address of the i2c node.
>> - Modify the description of 'atmel,sensor-preferred'.
>> - Add the description for the ISC internal clock.
>>
>>  .../devicetree/bindings/media/atmel-isc.txt        | 65 ++++++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/media/atmel-isc.txt
>
> Please add acks when posting new versions.
>
> Rob
>
Hi Rob,

Thank you for your reminder.

Should I Add 'Acked-by: Rob Herring <robh@kernel.org>' behind 
'Signed-off-by: Songjun Wu <songjun.wu@microchip.com>'?

Should I resend this patch?
