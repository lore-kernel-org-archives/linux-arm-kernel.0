From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Apr 2014 13:03:09 -0600
Subject: [PATCH 73/75] ARM: l2c: move L2 cache register saving to a more
 sensible location
In-Reply-To: <533B0BC1.6080608@wwwdotorg.org>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaF-0007Hv-Nv@rmk-PC.arm.linux.org.uk> <533B0BC1.6080608@wwwdotorg.org>
Message-ID: <533B0D6D.1080803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2014 12:56 PM, Stephen Warren wrote:
> On 03/28/2014 09:20 AM, Russell King wrote:
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> EXCEPT this one patch, the series,
> Tested-by: Stephen Warren <swarren@nvidia.com>
> (on Tegra20/Toshiba AC100 and Tegra30/Beaver)
> 
> And any part which touches Tegra code,
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> However, this one patch causes boot failures on the Toshiba AC100,
> Springbank/Seaboard, and I would assume any Tegra20 system. I haven't
> investigated what the problem is; do you need me to and/or have any clues?

Ah, disabling CONFIG_CPU_IDLE "fixes" this.
