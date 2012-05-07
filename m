From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 May 2012 09:47:17 -0600
Subject: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <20120507.143647.508182574757518311.hdoyu@nvidia.com>
References: <201205070859.29174.arnd@arndb.de><20120507.122333.2024326166703361049.hdoyu@nvidia.com><201205071024.48958.arnd@arndb.de>
 <20120507.143647.508182574757518311.hdoyu@nvidia.com>
Message-ID: <4FA7EE85.7030503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2012 05:36 AM, Hiroshi Doyu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Subject: Re: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
> Date: Mon, 7 May 2012 12:24:48 +0200
> Message-ID: <201205071024.48958.arnd@arndb.de>
> 
>> On Monday 07 May 2012, Hiroshi Doyu wrote:
>>> Tegra doesn't enable ARM_AMBA and Tegra doesn't use the following
>>> "drivers/amba/bus.c" right now. I needed to make this directory
>>> available to ones without ARM_AMBA enabled.
>>
>> Ah, right. I looked at arch/arm/Kconfig earlier to see if
>> tegra enabled ARM_AMBA but was accidentally looking
>> at ARCH_INtegraTOR when grepping for TEGRA ;-)
>>
>> Your proposed solution sounds good then.
> 
> Thank you for reviewing patches & ACK. Attached the update one here,
> instead of sending a while series again.

Russell, assuming you're OK with this update patch, is it OK if I take
the whole series through the Tegra tree?
