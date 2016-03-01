From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 1 Mar 2016 12:53:55 +0100
Subject: [PATCH 4/8] Documentation: devicetree: Document Tronsmart vendor
 prefix
In-Reply-To: <56D57EED.1090901@suse.com>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
 <1456789465-2962-5-git-send-email-afaerber@suse.de>
 <56D57EED.1090901@suse.com>
Message-ID: <56D582D3.3040902@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.03.2016 um 12:37 schrieb Matthias Brugger:
> On 01/03/16 00:44, Andreas F?rber wrote:
>> Choose the obvious prefix, "tronsmart".
>>
>> Cc: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
> 
> Same as a older patch I send some month ago. So also this is a trivial
> one, for the record:
> 
> Singed-off-by: Matthias Brugger <mbrugger@suse.com>

Hm, I see yours got an Acked-by from Rob on Jan 17. Through whose queue
is this supposed to go?

Searching for it, I even found a similar 2014 patch from Beniamino
Galvani (CC'ed), without any review replies.

I'll happily pick up one of the previous patches instead. Sorry, was in
a hurry to clean this series up for Nicolas (Mini Mx) and to avoid any
Odroid-C2 users duplicating my work.

Cheers,
Andreas

>>   Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index f871e8e7e98f..662edc7bce04 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -243,6 +243,7 @@ toshiba    Toshiba Corporation
>>   toumaz    Toumaz
>>   tplink    TP-LINK Technologies Co., Ltd.
>>   tronfy    Tronfy
>> +tronsmart    Tronsmart
>>   truly    Truly Semiconductors Limited
>>   upisemi    uPI Semiconductor Corp.
>>   urt    United Radiant Technology Corporation

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
