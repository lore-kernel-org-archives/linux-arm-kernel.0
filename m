From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Mar 2013 18:03:14 -0700
Subject: [PATCH 06/29] arm64: KVM: fault injection into a guest
In-Reply-To: <1362455265-24165-7-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <1363395794.3155.87.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, 2013-03-05 at 03:47 +0000, Marc Zyngier wrote:
> --- /dev/null
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -0,0 +1,117 @@

...

> + * kvm_inject_undefined - inject a undefined instruction into the guest

s/ a undefined/ an undefined/

-Geoff
