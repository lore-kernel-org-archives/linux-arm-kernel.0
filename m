From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Dec 2015 15:30:23 +0000
Subject: linux-4.4-rc5/arch/arm/kvm/emulate.c: minor bug report
In-Reply-To: <DUB128-W447E535904EF4165141E1B9CED0@phx.gbl>
References: <DUB128-W447E535904EF4165141E1B9CED0@phx.gbl>
Message-ID: <566EE08F.7070700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/12/15 14:48, David Binderman wrote:
> Hello there,
> 
> [linux-4.4-rc5/arch/arm/kvm/emulate.c:297]: (style) Variable 'new_spsr_value' is assigned a value that is never used.
> [linux-4.4-rc5/arch/arm/kvm/emulate.c:332]: (style) Variable 'new_spsr_value' is assigned a value that is never used.
> 
> They both look like candidates for deletion to me.

Ah. This seem to have been there since day 1 (almost 3 years ago).

I'll queue something to that effect.

Thanks for the report,

	M.
-- 
Jazz is not dead. It just smells funny...
