From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 21 Mar 2016 15:02:19 +0100
Subject: [PATCH] arm64: KVM: Turn kvm_ksym_ref into a NOP on VHE
In-Reply-To: <20160321124216.GA16859@cbox>
References: <1458321959-11728-1-git-send-email-marc.zyngier@arm.com>
 <CAKv+Gu_at5LXa5jxpM7h=ntxdJNNqmbtVE-bWn3SicMMMuT6Dg@mail.gmail.com>
 <56EFEABA.3010604@redhat.com> <20160321124216.GA16859@cbox>
Message-ID: <56EFFEEB.8020800@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/03/2016 13:42, Christoffer Dall wrote:
> Marc is on holiday this week, but I put this (with the fix) on top of
> Linus' master in the kvmarm/master branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git master
> 
> Do you want to just grab it from there?

Since you have two more patches, I guess you can just send a pull
request for all three.  I plan to send mine to Linus on Wednesday.

Thanks,

Paolo
