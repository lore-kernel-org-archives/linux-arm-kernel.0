From: dingtianhong@huawei.com (Ding Tianhong)
Date: Mon, 24 Oct 2016 20:40:01 +0800
Subject: [PATCH 1/3] arm64: arch_timer: Add device tree binding for
 hisilicon-161x01 erratum
In-Reply-To: <20161024111608.GG15620@leverpostej>
References: <962ea92f-870b-e1d0-5bb7-1a6d66c35122@huawei.com>
 <20161024111608.GG15620@leverpostej>
Message-ID: <7e839df8-f8f7-3b16-8321-4ff45b6c5884@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/24 19:16, Mark Rutland wrote:
> On Sun, Oct 23, 2016 at 11:21:10AM +0800, Ding Tianhong wrote:
>> +- hisilicon,erratum-161x01 : A boolean property. Indicates the presence of
>> +  QorIQ erratum 161201, which says that reading the counter is
>> +  unreliable unless the small range of value is returned by back-to-back reads.
>> +  This also affects writes to the tval register, due to the implicit
>> +  counter read.
> 
> Is "161x01" the *exact* erratum number, or is the 'x' a wildcard? Please
> use the *exact* erratum number, even if that means we have to list
> several.
> 

Hi Mark:

The 'x' is a wildcard, it will cover 161001 to 161601 several numbers, I will discuss to
the chip develop and get a exact erratum number.

Thanks.
Ding

> Is "161x01" an *erratum* number, or the *part* number of affected
> devices?
> 
> Thanks,
> Mark.
> 
> .
> 
