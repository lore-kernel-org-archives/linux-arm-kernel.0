From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 May 2013 12:47:45 +0200
Subject: ARM Cortex-A7 support in Linux
In-Reply-To: <A1A6EA40F8503D48BB002B42BD65974E295341@039-SN2MPN1-012.039d.mgd.msft.net>
References: <A1A6EA40F8503D48BB002B42BD65974E295341@039-SN2MPN1-012.039d.mgd.msft.net>
Message-ID: <f6c9d2b0d52d63efa95f780b172690ef@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 May 2013 09:56:22 +0000, Sharma Bhupesh-B45370
<B45370@freescale.com> wrote:

> But I am not sure about the following:
> - Does the current GIC driver support GIC-400 features as well?

It depends which feature you're after. Linux supports the GIC
virtualization extensions with KVM, for example. But we don't make any use
of other things like priorities, split deactivation/priority drop...

         M.
-- 
Fast, cheap, reliable. Pick two.
