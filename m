From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 May 2014 09:58:33 -0600
Subject: [PATCH] ARM: tegra: Support reboot modes
In-Reply-To: <1399388651-12819-1-git-send-email-thierry.reding@gmail.com>
References: <1399388651-12819-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <536A5829.5030702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2014 09:04 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The boot ROM on Tegra SoCs supports booting into forced recovery mode
> (RCM) by setting a bit in the PMC scratch register 0. Similarily, the
> Android bootloader examines some of the bits in this register to disable
> autoboot or enter recovery mode.
> 
> Support these modes by setting the corresponding bits depending on the
> specified reboot command (forced-recovery, bootloader, recovery). Recent
> systemd-based distributions allow this to be specified using an optional
> argument to the reboot command.

Applied to Tegra's for-3.16/soc branch.
