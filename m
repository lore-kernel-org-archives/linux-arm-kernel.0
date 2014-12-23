From: Ying.Liu@freescale.com (Liu Ying)
Date: Tue, 23 Dec 2014 16:26:37 +0800
Subject: [PATCH RFC v3 02/18] of: Add vendor prefix for Himax Technologies
 Inc.
In-Reply-To: <789433791.920346.1419322152848.JavaMail.open-xchange@oxbaltgw08.schlund.de>
References: <1419306399-9387-1-git-send-email-Ying.Liu@freescale.com>
 <1419306399-9387-3-git-send-email-Ying.Liu@freescale.com>
 <789433791.920346.1419322152848.JavaMail.open-xchange@oxbaltgw08.schlund.de>
Message-ID: <5499273D.3040900@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 12/23/2014 04:09 PM, Stefan Wahren wrote:
> Hi Liu,
>
>> Liu Ying <Ying.Liu@freescale.com> hat am 23. Dezember 2014 um 04:46
>> geschrieben:
>>
>>
>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>> ---
>> v2->v3:
>> * None.
>>
>> v1->v2:
>> * None.
>>
>> Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 78efebb..3cee528 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -69,6 +69,7 @@ hannstar HannStar Display Corporation
>> haoyu Haoyu Microelectronic Co. Ltd.
>> hisilicon Hisilicon Limited.
>> hit Hitachi Ltd.
>> +himax Himax Technologies, Inc.
>
> please fix the ordering. himax comes before hisilicon.

Yes. I'll fix that.

Thanks,
Liu Ying

>
> Thanks
>
> Stefan
>
>> honeywell Honeywell
>> hp Hewlett Packard
>> i2se I2SE GmbH
>> --
>> 2.1.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
