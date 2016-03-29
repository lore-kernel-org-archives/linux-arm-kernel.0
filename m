From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 29 Mar 2016 16:04:31 +0200
Subject: [PATCH 1/3] ARM: at91: use chipid device for soc detection
In-Reply-To: <55618572.U3p4crGV1Y@wuerfel>
References: <1458285681-25684-1-git-send-email-ludovic.desroches@atmel.com>
 <55618572.U3p4crGV1Y@wuerfel>
Message-ID: <56FA8B6F.4010008@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/03/2016 15:55, Arnd Bergmann a ?crit :
> On Friday 18 March 2016 08:21:19 Ludovic Desroches wrote:
>> -struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
>> +int __init at91_get_cidr_exid_from_dbgu(u32 *cidr, u32 *exid)
>>  {
> 
> 
>> +
>> +int __init at91_get_cidr_exid_from_chipid(u32 *cidr, u32 *exid)
>> +{
>>
> 
> These should both be 'static', right?

Absolutely. I modify this right now and repost a patch.

Bye,
-- 
Nicolas Ferre
