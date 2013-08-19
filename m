From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 10:11:45 -0600
Subject: [PATCH v2] extcon: palmas: Modified the compatible type to *ti,
 palmas-usb-vid*
In-Reply-To: <5211A7B3.4040906@ti.com>
References: <1376648448-27447-1-git-send-email-kishon@ti.com>
 <520EA5D6.3040409@wwwdotorg.org> <5211A7B3.4040906@ti.com>
Message-ID: <521243C1.3070701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2013 11:05 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Saturday 17 August 2013 03:51 AM, Stephen Warren wrote:
>> On 08/16/2013 04:20 AM, Kishon Vijay Abraham I wrote:
>>> The Palmas device contains only a USB VID detector, so modified the
>>> compatible type to *ti,palmas-usb-vid*.
>>
>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
>>
>>>  PALMAS USB COMPARATOR
>>>  Required Properties:
>>> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
>>> + - compatible : Should be "ti,palmas-usb-vid".
>>
>> Has the old value been published in a release kernel? If so, it makes
> 
> No. This was merged only in 3.11-rc1. So I think we should take this version?
> Chanwoo can you take this patch?

So anything in 3.11-rc1 will make it into 3.11 final, and hence has
already been published, and hence should be an ABI. This current patch
is only going into 3.12, so really should be amended not to break the ABI.
