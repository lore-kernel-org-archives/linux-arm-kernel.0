From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Apr 2015 10:31:05 -0500
Subject: [PATCH] devicetree: Add vendor prefix for Foxlink Group
In-Reply-To: <5540F5DD.5010101@atmel.com>
References: <1427213575-27340-1-git-send-email-nicolas.ferre@atmel.com>
 <5540F5DD.5010101@atmel.com>
Message-ID: <CAL_Jsq+r3YYTZ-w8JCeRgsbfwhNJ+mvjzkWH-152BJiEZbRN7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 10:16 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Le 24/03/2015 17:12, Nicolas Ferre a ?crit :
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>> Thierry,
>>
>> Boris added the support for a Foxlink panel in this commit: 102932b0e474
>> (drm/panel: add support for Foxlink FL500WVR00-A0T panel). Here is the vendor
>> prefix.
>
> Ping?

Acked-by: Rob Herring <robh@kernel.org>

>
>>
>> Bye,
>>
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 1b0f5b797cd5..e9fca088ba1a 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -73,6 +73,7 @@ everspin    Everspin Technologies, Inc.
>>  excito       Excito
>>  fcs  Fairchild Semiconductor
>>  firefly      Firefly
>> +foxlink      Foxlink Group
>>  fsl  Freescale Semiconductor
>>  GEFanuc      GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>>  gef  GE Fanuc Intelligent Platforms Embedded Systems, Inc.
>>
>
>
> --
> Nicolas Ferre
