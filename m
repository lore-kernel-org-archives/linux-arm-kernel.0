From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 15:11:21 -0600
Subject: [PATCH V3] ARM: tegra: cpuidle: remove redundant parameters for
 powered-down mode
In-Reply-To: <1364901650-25335-1-git-send-email-josephl@nvidia.com>
References: <1364901650-25335-1-git-send-email-josephl@nvidia.com>
Message-ID: <515C9AF9.9060007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 05:20 AM, Joseph Lo wrote:
> After the patch series for system suspending support, tegra_idle_lp2_last()
> no longer uses its parameters cpu_on_time or cpu_off_time, so remove them.

Applied to Tegra's for-3.10/soc branch.
