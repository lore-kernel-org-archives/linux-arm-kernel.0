From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 14 Oct 2016 16:10:04 -0500
Subject: [PATCH v3 1/2] devicetree: Add vendor prefix for Rikomagic
In-Reply-To: <7746988.aAT8rmUZDV@phil>
References: <cover.1475957884.git.paweljarosz3691@gmail.com>
 <d51c7719a314f723a0a69b932997502a2fe0e3ee.1475957884.git.paweljarosz3691@gmail.com>
 <7746988.aAT8rmUZDV@phil>
Message-ID: <CAL_JsqJZoTa2ui_st1CeY96Qoaa3oXhvbGSUywWFbEfGC+KUqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2016 at 1:21 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Samstag, 8. Oktober 2016, 22:22:05 CEST schrieb Pawe? Jarosz:
>> Add Rikomagic to vendor-prefixes.txt
>>
>> Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
>> ---
>>
>> Changes in v2:
>> - none
>>
>> Changes in v3:
>> - none
>>
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> b/Documentation/devicetree/bindings/vendor-prefixes.txt index
>> 69caf14..3edfa08 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -224,6 +224,7 @@ realtek Realtek Semiconductor Corp.
>>  renesas      Renesas Electronics Corporation
>>  richtek      Richtek Technology Corporation
>>  ricoh        Ricoh Co. Ltd.
>> +rikomagic    Rikomagic
>                                 ^ Rikomagic Tech Corp. Ltd
>
> (according to http://www.rikomagic.com/en/index.html)
>
> But I can change that myself. I'll just need to wait a bit more if Rob or Mark
> want to Ack this vendor-prefix addition.

Acked-by: Rob Herring <robh@kernel.org>
