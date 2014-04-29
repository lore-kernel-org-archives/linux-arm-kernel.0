From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 29 Apr 2014 17:40:02 +0800
Subject: [PATCH 70/97] ARM: l2c: tegra: convert to common l2c310 early
 resume functionality
In-Reply-To: <535EBD19.4060304@wwwdotorg.org>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerHd-0001YS-LA@rmk-PC.arm.linux.org.uk> <535EBD19.4060304@wwwdotorg.org>
Message-ID: <535F7372.5000507@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 04:42 AM, Stephen Warren wrote:
> On 04/28/2014 01:32 PM, Russell King wrote:
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Tested-by: Stephen Warren <swarren@nvidia.com>
>
> (On Springbank/Tegra20 and Beaver/Tegra30; tested suspend/resume via RTC
> wakealarm IRQ)
>
> Joseph, if you see any issue here, please respond. Thanks.
>

Thanks for taking care of this. LGTM.

Reviewed-by: Joseph Lo <josephl@nvidia.com>
