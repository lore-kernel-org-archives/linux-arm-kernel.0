From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 19 Aug 2015 16:21:14 -0700
Subject: [PATCH v4 1/2] arm64: KVM: Optimize arm64 skip 30-50% vfp/simd
 save/restore on exits
In-Reply-To: <20150819232839.69531eca@arm.com>
References: <1437082178-11039-1-git-send-email-m.smarduch@samsung.com>
 <1437082178-11039-2-git-send-email-m.smarduch@samsung.com>
 <55C235B9.3000800@arm.com> <20150819174958.GA11518@cbox>
 <55D4FA88.5060305@samsung.com> <20150819232839.69531eca@arm.com>
Message-ID: <55D50F6A.9020604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Great that's even better.

On 8/19/2015 3:28 PM, Marc Zyngier wrote:
> On Wed, 19 Aug 2015 14:52:08 -0700
> Mario Smarduch <m.smarduch@samsung.com> wrote:
> 
>> Hi Christoffer,
>>    I'll test it and work with it.
> 
> FWIW, I've added these patches to both -queue and -next, and from the
> tests Christoffer has run, it looks pretty good.
> 
> Thanks,
> 
> 	M.
> 
