From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 May 2016 09:02:24 +0100
Subject: [PATCH v2] KVM: arm/arm64: vgic-new: Switch to
 firmware-independent probing
In-Reply-To: <20160512190216.GO27623@cbox>
References: <1462869983-5410-1-git-send-email-marc.zyngier@arm.com>
 <20160512190216.GO27623@cbox>
Message-ID: <57358A10.8070404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/16 20:02, Christoffer Dall wrote:
> On Tue, May 10, 2016 at 09:46:23AM +0100, Marc Zyngier wrote:
>> As we did for the legacy code, switch the new VGIC implementation
>> the firmware-independent probing, giving us ACPI support for free.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> So just remembered you wrote this after sending my comments to patch 48.
> 
> Are we planning to squash this into the series so I can review in
> completeness/with context, or?

This should indeed be squashed in the existing series, no need for an
intermediate step.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
