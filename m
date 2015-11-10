From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Tue, 10 Nov 2015 13:11:36 -0500
Subject: [PATCH v2 01/10] of: Add vendor prefix for Advantech Corporation
In-Reply-To: <20151105202213.GA7468@rob-hp-laptop>
References: <1446747224-32514-1-git-send-email-akshay.bhat@timesys.com>
 <1446747224-32514-2-git-send-email-akshay.bhat@timesys.com>
 <20151105202213.GA7468@rob-hp-laptop>
Message-ID: <56423358.7070908@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/05/2015 03:22 PM, Rob Herring wrote:
> On Thu, Nov 05, 2015 at 01:13:35PM -0500, Akshay Bhat wrote:
>> This patch adds vendor prefix for Advantech Corporation.
>>
>> Website: http://www.advantech.com/
>> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
>> ---
>>   Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 55df1d4..2b3c5ac 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -10,6 +10,7 @@ ad	Avionic Design GmbH
>>   adapteva	Adapteva, Inc.
>>   adh	AD Holdings Plc.
>>   adi	Analog Devices, Inc.
>> +adv	Advantech Corporation
>
> adv is a bit short. I think it would be better to go with "advantech".
>
> Rob
>

Fixed in v3.

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384203.html

>>   aeroflexgaisler	Aeroflex Gaisler AB
>>   al	Annapurna Labs
>>   allwinner	Allwinner Technology Co., Ltd.
>> --
>> 2.6.2
>>
