From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 16 Jun 2014 16:01:02 -0600
Subject: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
In-Reply-To: <1401881559-18469-7-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-7-git-send-email-mperttunen@nvidia.com>
Message-ID: <539F691E.5030204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> This symbol needs to be exported to power on rails without using
> tegra_powergate_sequence_power_up. tegra_powergate_sequence_power_up
> cannot be used in situations where the driver wants to handle clocking
> by itself.

Thierry, are you OK with this change?
