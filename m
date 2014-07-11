From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 11 Jul 2014 22:47:11 +0200
Subject: [PATCH v6 01/21] irqchip: ARM: GIC: Move some bits of GICv2 to
 a library-type file
In-Reply-To: <20140711161550.GA2093@cbox>
References: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
 <1404140510-5382-2-git-send-email-marc.zyngier@arm.com>
 <20140708223145.GG13433@titan.lakedaemon.net> <20140711161550.GA2093@cbox>
Message-ID: <53C04D4F.5000605@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 11/07/2014 18:15, Christoffer Dall ha scritto:
> Thanks, I've pushed
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git queue
>
>
> which will pretty much be the pull request to kvm/next (still need to
> test a few bits before moving to next and make it stable to be included
> in kvm/next).
>
> Will coordinate with Paolo to make sure commit
> 021f653791ad17e03f98aaa7fb933816ae16f161 lands in Linus' tree before
> sending the KVM pull-request.

So I'll send out the KVM changes early when the merge window open, and 
then pull from you and send the result to Linus in a second request.  Ok?

Paolo
