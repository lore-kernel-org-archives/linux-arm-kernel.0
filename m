From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 19 Aug 2013 14:59:07 +0530
Subject: [PATCH v2] extcon: palmas: Modified the compatible type to *ti,
 palmas-usb-vid*
In-Reply-To: <5211E45B.1010109@samsung.com>
References: <1376648448-27447-1-git-send-email-kishon@ti.com>
 <520EA5D6.3040409@wwwdotorg.org> <5211A7B3.4040906@ti.com>
 <5211DBB4.6090508@ti.com> <5211E45B.1010109@samsung.com>
Message-ID: <5211E563.6080200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 August 2013 02:54 PM, Chanwoo Choi wrote:
> On 08/19/2013 05:47 PM, Kishon Vijay Abraham I wrote:
>> On Monday 19 August 2013 10:35 AM, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Saturday 17 August 2013 03:51 AM, Stephen Warren wrote:
>>>> On 08/16/2013 04:20 AM, Kishon Vijay Abraham I wrote:
>>>>> The Palmas device contains only a USB VID detector, so modified the
>>>>> compatible type to *ti,palmas-usb-vid*.
>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
>>>>
>>>>>  PALMAS USB COMPARATOR
>>>>>  Required Properties:
>>>>> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
>>>>> + - compatible : Should be "ti,palmas-usb-vid".
>>>>
>>>> Has the old value been published in a release kernel? If so, it makes
>>>
>>> No. This was merged only in 3.11-rc1. So I think we should take this version?
>>> Chanwoo can you take this patch?
>>
>> Ah.. the old values will be part of 3.11 kernel. So should we retain the old
>> values?
> 
> What is the meaning of old value? previous value related to extcon-twl.txt?

We were discussing on whether to have "ti,palmas-usb" or "ti,twl6035-usb" in
compatible value in addition to "ti,palmas-usb-vid". Stephen wanted the old
values ("ti,palmas-usb" or "ti,twl6035-usb") if it has been published in a
release kernel.
> 
> The extcon-twl.txt was included in 3.11 kernel

Right. Since it's part of 3.11 kernel, I think we should retain the old
compatible values.

Thanks
Kishon
