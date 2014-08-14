From: tharvey@gateworks.com (Tim Harvey)
Date: Wed, 13 Aug 2014 18:13:35 -0700
Subject: [PATCH] devicetree: bindings: Document Gateworks vendor prefix
In-Reply-To: <53E7D325.4060802@gmail.com>
References: <1407658509-1773-1-git-send-email-tharvey@gateworks.com>
 <53E7D325.4060802@gmail.com>
Message-ID: <CAJ+vNU1QXMMke+pUy6xbxaYhNqqRivM=_qLpVLPePTQLicj_Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 10, 2014 at 1:16 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Le 10/08/2014 01:15, Tim Harvey a ?crit :
>
>> Add Gateworks Corporation to the list of device tree vendor prefixes.
>>
>> Gateworks designs and manufactures single board computers designed for
>> embedded wireless and wired network applications.
>>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>>   Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 46a311e..803fa4f 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -54,6 +54,7 @@ globalscale   Globalscale Technologies, Inc.
>>   gmt   Global Mixed-mode Technology, Inc.
>>   google        Google, Inc.
>>   gumstix       Gumstix, Inc.
>> +gw     Gateworks Corporation
>
>
> I would go with "gateworks" here, "gw" is usually a shorter term for
> "gateway", and there is an actual company called "Gateway" also
> manufacturing various types of computers.
> --
> Florian

Hi Florian,

Well... I got to the table first with Gateworks so I don't see why I
can't take the 'gw' prefix personally. Note that I do have several
devicetree files in arch/arm/dts/imx6-gw*.dts* already in mainline
that use the 'gw' vendor prefix (albeit one could argue that I should
have been asked to add 'gw' to the vendor-prefixes.txt back then, but
that is not the way things went down).

Tim
