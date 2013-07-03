From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 03 Jul 2013 10:20:17 +0100
Subject: Proposal: mach-dt
In-Reply-To: <1372839486.487159774@f54.mail.ru>
References: <1372839486.487159774@f54.mail.ru>
Message-ID: <51D3ECD1.8030305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/13 09:18, Alexander Shiyan wrote:

Hi Alexander,

> More and more platforms are now using devicetree.
> Ideally the platform code contains only one function "of_platform_populate".
> My idea is to make a generic architecture (mach-dt) with the call then add support
> for compatible subarchitectures as they become available in "compatible"-property.
> Your opinion?

Well, my (admittedly partial) opinion is that mach-virt is an incredibly
nicer sounding name, 'specially as you can mistype it as mach-triv.

More seriously, arch/arm/mach-virt is probably what you need.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
