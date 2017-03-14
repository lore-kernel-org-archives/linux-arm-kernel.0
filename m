From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 Mar 2017 16:09:44 +0000
Subject: [PATCH v3 00/25] arm/arm64: KVM: Rework the hyp-stub API
In-Reply-To: <20170314160545.GP21222@n2100.armlinux.org.uk>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
 <20170314160545.GP21222@n2100.armlinux.org.uk>
Message-ID: <4bf5788f-7ed8-198e-8089-1c7a8385f96b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/17 16:05, Russell King - ARM Linux wrote:
> On Mon, Mar 06, 2017 at 02:24:33PM +0000, Marc Zyngier wrote:
>> As noticed by RMK in this thread[1], the hyp-stub API on 32bit ARM
>> could do with some TLC (it cannot perform a soft-restart at HYP, and
>> has holes in the hyp-stub support in a number of places). In general,
>> it would be desirable for the 32bit behaviour to align on 64bit, if
>> only to ease maintenance.
> 
> What's the merge plan for this?

If you're happy with it (together with Christoffer, Will and Catalin), I
plat to take it through the kvmarm tree.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
