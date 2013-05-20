From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 May 2013 17:20:43 -0600
Subject: [PATCH V2 0/6] ARM: tegra114: add CPU hotplug support
In-Reply-To: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
References: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
Message-ID: <519AAFCB.8060007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2013 04:39 AM, Joseph Lo wrote:
> Tegra 114 is different with other Tegra SoC chips. It using ARM Cortex-A15
> as CPU core and a enhanced flow controller for CPU power control. So
> we need to skip some code that was for Contex-A9 and some other support
> code that was for other Tegra SoC chips. Then adding the proper power up
> and hot plug control for Tegra114.

This version still doesn't enable hotplug of CPU0, yet at least patch
6/6 contains some changes that support enabling that. Are you planning
on sending a separate patch to enable this later, or was this an oversight?
