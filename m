From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 04 Oct 2011 10:47:26 +0100
Subject: [PATCH v4 05/10] ARM: SoC: convert Tegra to SoC descriptor
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173A2C6DD0@HQMAIL01.nvidia.com>
References: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
	<1317663356-5114-6-git-send-email-marc.zyngier@arm.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173A2C6DD0@HQMAIL01.nvidia.com>
Message-ID: <4E8AD62E.5040207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/11 21:52, Stephen Warren wrote:
> Marc Zyngier wrote at Monday, October 03, 2011 11:36 AM:
>> Convert Tegra to use the SoC descriptor to provide its SMP
>> and CPU hotplug operations.
> 
>> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
> ...
>> +struct arm_soc_desc tegra_soc_desc __initdata = {
>> +	.name		= "nVIDIA Tegra",
> 
> Technically, we're supposed to say "NVIDIA" not "nVIDIA", but no need to
> respin just for that! So,

Ah! I'll fix that in my tree. There's a pending respin anyway...

> Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks Stephen.

	M.
-- 
Jazz is not dead. It just smells funny...
