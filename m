From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 14:42:01 -0600
Subject: [PATCH 70/97] ARM: l2c: tegra: convert to common l2c310 early
 resume functionality
In-Reply-To: <E1WerHd-0001YS-LA@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerHd-0001YS-LA@rmk-PC.arm.linux.org.uk>
Message-ID: <535EBD19.4060304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 01:32 PM, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>

(On Springbank/Tegra20 and Beaver/Tegra30; tested suspend/resume via RTC
wakealarm IRQ)

Joseph, if you see any issue here, please respond. Thanks.
