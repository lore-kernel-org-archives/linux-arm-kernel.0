From: david@lechnology.com (David Lechner)
Date: Fri, 13 Jan 2017 12:20:46 -0600
Subject: [PATCH v3] ARM: dts: Add LEGO MINDSTORMS EV3 dts
In-Reply-To: <0d69ff4b-c3a6-5126-2590-2268d3b25f92@lechnology.com>
References: <1484253167-27568-1-git-send-email-david@lechnology.com>
 <3066d614-0676-319a-6149-6d723e1cf35f@ti.com>
 <0d69ff4b-c3a6-5126-2590-2268d3b25f92@lechnology.com>
Message-ID: <f73840dd-6373-e554-311f-d92c1bed060f@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2017 12:16 PM, David Lechner wrote:
> On 01/13/2017 06:04 AM, Sekhar Nori wrote:
>> On Friday 13 January 2017 02:02 AM, David Lechner wrote:
>>> This adds a device tree definition file for LEGO MINDSTORMS EV3.
>>>
> ...
>>
>> There are couple of checkpatch errors that show up. The compatible
>> "lego,ev3" needs to be documented in
>> Documentation/devicetree/bindings/arm/davinci.txt
>>
>> "at24,24c128" is undocumented. Is that an atmel chip on the EV3? If the
>> manufacturer name is not clear,
>> Documentation/devicetree/bindings/eeprom/eeprom.txt advises using just
>> "24c128"
>
> The mfg is microchip, so I guess I will just go with "24c128"

I think I have let the device tree bindings doc confuse me. On second 
though, I think the correct thing is to included the manufacturer.

>
>>
>> Finally, lego needs to be added to
>> Documentation/devicetree/bindings/vendor-prefixes.txt
>>
>> Can you please submit the documentation portions as separate patches in
>> a series along with this patch.
>
> Yes.
>
>>
>> Thanks,
>> Sekhar
>>
>
