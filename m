From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 6 Mar 2013 16:49:46 -0800
Subject: [PATCH] ARM: KVM: add support for minimal host vs guest profiling
In-Reply-To: <1362453480-23886-1-git-send-email-marc.zyngier@arm.com>
References: <1362453480-23886-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130307004946.GB23427@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 03:18:00AM +0000, Marc Zyngier wrote:
> In order to be able to correctly profile what is happening on the
> host, we need to be able to identify when we're running on the guest,
> and log these events differently.
> 
> Perf offers a simple way to register callbacks into KVM. Mimic what
> x86 does and enjoy being able to profile your KVM host.

Thanks, this has been applied to kvm-arm-next.

-Christoffer
