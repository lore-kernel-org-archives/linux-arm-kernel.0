From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 13 Oct 2014 12:44:49 +0200
Subject: [PATCH v4 08/10] add Alphascale to vendor-prefixes.txt
In-Reply-To: <CAL_JsqLTJzFpX_LZdCSWKnRkAZHu-xX_KzNX3jCDnyTMdWefLg@mail.gmail.com>
References: <1413141561-8916-1-git-send-email-linux@rempel-privat.de>
 <1413141561-8916-9-git-send-email-linux@rempel-privat.de>
 <CAL_JsqLTJzFpX_LZdCSWKnRkAZHu-xX_KzNX3jCDnyTMdWefLg@mail.gmail.com>
Message-ID: <543BAD21.1090402@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do it make sense to push this patch separately? Right now it looks like
this patch set will be pingponged some more times :/

Am 13.10.2014 um 01:19 schrieb Rob Herring:
> On Sun, Oct 12, 2014 at 2:19 PM, Oleksij Rempel <linux@rempel-privat.de> wrote:
>> this company already provided some products, so it make sense to add
>> them to vendor-prefixes.txt list
>>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index ac7269f..23c862f 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -11,6 +11,7 @@ adi   Analog Devices, Inc.
>>  aeroflexgaisler        Aeroflex Gaisler AB
>>  ak     Asahi Kasei Corp.
>>  allwinner      Allwinner Technology Co., Ltd.
>> +alphascale     AlphaScale Integrated Circuits Systems, Inc.
>>  altr   Altera Corp.
>>  amcc   Applied Micro Circuits Corporation (APM, formally AMCC)
>>  amd    Advanced Micro Devices (AMD), Inc.
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141013/3fc3d183/attachment.sig>
