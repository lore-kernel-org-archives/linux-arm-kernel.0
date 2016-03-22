From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 22 Mar 2016 08:33:36 +0100
Subject: [PATCH] arm64: KVM: Turn kvm_ksym_ref into a NOP on VHE
In-Reply-To: <56F05FD7.9070706@redhat.com>
References: <1458321959-11728-1-git-send-email-marc.zyngier@arm.com>
 <CAKv+Gu_at5LXa5jxpM7h=ntxdJNNqmbtVE-bWn3SicMMMuT6Dg@mail.gmail.com>
 <56EFEABA.3010604@redhat.com> <20160321124216.GA16859@cbox>
 <56EFFEEB.8020800@redhat.com> <20160321185524.GD16859@cbox>
 <56F05FD7.9070706@redhat.com>
Message-ID: <20160322073336.GA21047@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 09:55:51PM +0100, Paolo Bonzini wrote:
> 
> 
> On 21/03/2016 19:55, Christoffer Dall wrote:
> > > Since you have two more patches, I guess you can just send a pull
> > > request for all three.  I plan to send mine to Linus on Wednesday.
> > 
> > Sounds good, I'll send you one tomorrow (based on Linus' master branch
> > of today - if that works?)
> 
> Anything that you can test with works.  Even basing it on your last pull
> request is okay for me, and it's better for future bisection if there's
> some known breakage in Linus's master branch.
> 
The changes to kvm_ksym_ref() didn't apply to anything in the kvmarm
side of things but needed stuff from Catalin, so I just applied it on
top of Linus' master.

I'll send you the pull request later and just holler if I need to change
it somehow.

Thanks,
-Christoffer
