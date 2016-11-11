From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Nov 2016 10:23:20 +0000
Subject: [PULL 0/3] KVM/ARM updates for v4.9-rc4
In-Reply-To: <09984771-dfe4-1811-7d2e-29eaf34d99a9@redhat.com>
References: <20161104183638.28137-1-marc.zyngier@arm.com>
 <09984771-dfe4-1811-7d2e-29eaf34d99a9@redhat.com>
Message-ID: <8ba4f486-e9f8-ae85-6647-29b1ffb31c97@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/16 10:14, Paolo Bonzini wrote:
> 
> 
> On 04/11/2016 19:36, Marc Zyngier wrote:
>>   git://git.kernel.org:/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-v4.9-rc4
> 
> What is the extra colon after "org"? :)

That's obviously me screwing up when hacking the .git/config to have
different fetch and push URLs. The odd thing is that git (2.10.1)
doesn't even complain and happily pulls the branch... Did you get an
error? Anyway, I'll fix that in my local config.

> Pulled now, and I will send it in time for rc5.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
