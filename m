From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 04 Oct 2011 10:44:53 +0100
Subject: [PATCH v4 04/10] ARM: SoC: convert OMAP4 to SoC descriptor
In-Reply-To: <CAMQu2gzg9B0ABaay9DSfNvfT6R3tLRW9DfgUuNphy3+y5PxH2Q@mail.gmail.com>
References: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
	<1317663356-5114-5-git-send-email-marc.zyngier@arm.com>
	<CAMQu2gzg9B0ABaay9DSfNvfT6R3tLRW9DfgUuNphy3+y5PxH2Q@mail.gmail.com>
Message-ID: <4E8AD595.2030201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/11 07:32, Shilimkar, Santosh wrote:
> Marc,
> 
> On Mon, Oct 3, 2011 at 11:05 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Convert OMAP4 to use the SoC descriptor to provide its SMP
>> and CPU hotplug operations.
>>
>> Tested on both Panda and IGEPv2 (MULTI_OMAP kernel)
>>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
> The changes very trivial and they look fine to me.
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks Santosh.

	M.
-- 
Jazz is not dead. It just smells funny...
