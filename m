From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 30 Aug 2016 16:34:32 +0100
Subject: Older hisilicon chipsets
In-Reply-To: <7d7ff37b-a16b-8532-214c-de0a46c9de8e@gmail.com>
References: <7773f0e5-d045-1e93-529b-74a601467ed1@gmail.com>
 <20160827150457.GM10637@io.lakedaemon.net>
 <ec3ec22f-f05e-aaec-8e9a-bfc0565b9e9d@gmail.com> <7850061.5OOjP34nIO@wuerfel>
 <57C54A05.9090601@hisilicon.com>
 <7d7ff37b-a16b-8532-214c-de0a46c9de8e@gmail.com>
Message-ID: <57C5A788.8090901@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marty,

On 30/08/2016 15:43, Marty Plummer wrote:
> On 08/30/2016 03:55 AM, Wei Xu wrote:
>> Hi Arnd, Marty
>>
>> I will once they are ready.
>> Thanks for your kindly guiding!
>>
>> Best Regards,
>> Wei
>>
>>
> Hi Wei,
> 
> Do you think you could change the references to the Hi3620 in the code
> and dts files from `hi3xxx' to `hi3620'? As it currently stands, the
> wildcard matches hi3520 too, but that's not a good idea whit devicetree,
> its best to be completely explicit as to which sort of device the
> binding is for.

Yes, originally it also stands for hi3519 and please send the patch to me.
Please do not add a new DT_MACHINE entry if we could use the general one.
Thanks?

Best Regards,
Wei

> 
> Thanks.
> 
