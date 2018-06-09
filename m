From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 09 Jun 2018 14:21:47 +0100
Subject: [PATCH v2 12/17] arm64: KVM: Add ARCH_WORKAROUND_2 support for
 guests
In-Reply-To: <98318e6c-adcd-ddb8-ad92-e7c1fa771c84@jonmasters.org>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
 <20180529121121.24927-13-marc.zyngier@arm.com>
 <98318e6c-adcd-ddb8-ad92-e7c1fa771c84@jonmasters.org>
Message-ID: <86tvqc8590.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 09 Jun 2018 14:09:35 +0100,
Jon Masters wrote:
> 
> On 05/29/2018 08:11 AM, Marc Zyngier wrote:
> > In order to offer ARCH_WORKAROUND_2 support to guests, we need
> > a bit of infrastructure.
> > 
> > Let's add a flag indicating whether or not the guest uses
> > SSBD mitigation. Depending on the state of this flag, allow
> > KVM to disable ARCH_WORKAROUND_2 before entering the guest,
> > and enable it when exiting it.
> 
> ...Live migration?

Work in progress.

	M.

-- 
Jazz is not dead, it just smell funny.
