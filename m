From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 11 Dec 2014 12:59:58 +0100
Subject: [GIT PULL 0/9] KVM/ARM Changes for v3.19
In-Reply-To: <54898585.8020006@redhat.com>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
 <54898585.8020006@redhat.com>
Message-ID: <20141211115958.GF28388@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 12:52:37PM +0100, Paolo Bonzini wrote:
> 
> 
> On 09/12/2014 12:25, Christoffer Dall wrote:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git kvm-arm-for-3.19
> 
> Pulled, thanks.
> 
> (In case you're wondering, this merge window I'll send the pull request
> late to avoid multiple conflicts with the ia64 removal).
> 
ok, we are considering sending the regression fix for the vgic init
stuff as an additional pull request next week, depending on available
cycles for reviewing an testing:

https://lists.cs.columbia.edu/pipermail/kvmarm/2014-December/012743.html

We also have a series which clarifies the ABI and fixes guest reboot
issues and guest UEFI issues, which seems to be quieting down.  Since
that is technically a fix, we could merge that for -rc2?

https://lists.cs.columbia.edu/pipermail/kvmarm/2014-December/012635.html

Would both be ok with you?

-Christoffer
