From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 19 Aug 2013 10:35:55 +0530
Subject: [PATCH v2] extcon: palmas: Modified the compatible type to *ti,
 palmas-usb-vid*
In-Reply-To: <520EA5D6.3040409@wwwdotorg.org>
References: <1376648448-27447-1-git-send-email-kishon@ti.com>
 <520EA5D6.3040409@wwwdotorg.org>
Message-ID: <5211A7B3.4040906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 17 August 2013 03:51 AM, Stephen Warren wrote:
> On 08/16/2013 04:20 AM, Kishon Vijay Abraham I wrote:
>> The Palmas device contains only a USB VID detector, so modified the
>> compatible type to *ti,palmas-usb-vid*.
> 
>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
> 
>>  PALMAS USB COMPARATOR
>>  Required Properties:
>> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
>> + - compatible : Should be "ti,palmas-usb-vid".
> 
> Has the old value been published in a release kernel? If so, it makes

No. This was merged only in 3.11-rc1. So I think we should take this version?
Chanwoo can you take this patch?

Thanks
Kishon
