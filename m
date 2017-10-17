From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 17 Oct 2017 22:00:59 +0800
Subject: [PATCH] arm64: KVM: set right LR register value for 32 bit guest
 when inject abort
In-Reply-To: <20171016195901.GA5753@lvm>
References: <0184EA26B2509940AA629AE1405DD7F201699F61@DGGEMA503-MBX.china.huawei.com>
 <20171016195901.GA5753@lvm>
Message-ID: <0b35fe8c-59d9-96bd-2e61-66e7a2d463fc@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer

On 2017/10/17 3:59, Christoffer Dall wrote:
> On Mon, Oct 16, 2017 at 04:10:01PM +0000, gengdongjiu wrote:
>> Hi Marc,
>>
>>>
>>> Please also update the 32bit code accordingly, as it looks broken too.
>>
>> I have updated the 32 bit code according, in my hand, there is no arm32 host environment,
>> So there is no method to verify it in the arm32 host, only verify the patch in the arm64 host.
>>
>> Anyway I firstly send the patch out for review. Thanks.
>>
> In this case, if you just clearly specify in the patches you send out
> that the 32-bit one is untested, you can ask someone to test it for you.
> 

Thanks for your reminder, today I found a arm32 board and have tested it.
So I have tested in both arm32 and arm64. please review it. thanks.


> Thanks,
> -Christoffer
> 
> .
> 
