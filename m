From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 13 Mar 2015 10:24:21 +0000
Subject: [PATCH] arm/arm64: KVM: fix missing unlock on error in
 kvm_vgic_create()
In-Reply-To: <20150302172947.GC10137@lvm>
References: <1425037305-23292-1-git-send-email-weiyj_lk@163.com>
 <20150302172947.GC10137@lvm>
Message-ID: <5502BAD5.3040004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej Christoffer,

On 02/03/15 17:29, Christoffer Dall wrote:
> On Fri, Feb 27, 2015 at 07:41:45PM +0800, weiyj_lk at 163.com wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> Add the missing unlock before return from function kvm_vgic_create()
>> in the error handling case.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Thanks, applied.

Have I missed this or is this patch nor appearing in any of your branches?

Cheers,
Andre.
