From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 13 Mar 2015 11:41:35 +0100
Subject: [PATCH] arm/arm64: KVM: fix missing unlock on error in
 kvm_vgic_create()
In-Reply-To: <5502BAD5.3040004@arm.com>
References: <1425037305-23292-1-git-send-email-weiyj_lk@163.com>
 <20150302172947.GC10137@lvm> <5502BAD5.3040004@arm.com>
Message-ID: <20150313104135.GA11230@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 10:24:21AM +0000, Andre Przywara wrote:
> Hej Christoffer,
> 
> On 02/03/15 17:29, Christoffer Dall wrote:
> > On Fri, Feb 27, 2015 at 07:41:45PM +0800, weiyj_lk at 163.com wrote:
> >> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >>
> >> Add the missing unlock before return from function kvm_vgic_create()
> >> in the error handling case.
> >>
> >> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > Thanks, applied.
> 
> Have I missed this or is this patch nor appearing in any of your branches?
> 
It was on my laptop branch because I applied while being on a plane.

I've updated the kvmarm/master branch with this fix.

Thanks for reminding me.
-Christoffer
