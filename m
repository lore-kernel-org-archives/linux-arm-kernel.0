From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 May 2013 15:31:34 -0600
Subject: [PATCH V2] ARM: tegra: add cpu_disable for hotplug
In-Reply-To: <1369764881-20520-1-git-send-email-swarren@wwwdotorg.org>
References: <1369764881-20520-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51A52236.5030001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2013 12:14 PM, Stephen Warren wrote:
> From: Joseph Lo <josephl@nvidia.com>
> 
> The Tegra114 could hotplug the CPU0, but the common cpu_disable didn't
> support that. Adding a Tegra specific cpu_disable function for it.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> [swarren: adjusted the switch statement to be future-proof]
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

I have applied this to Tegra's for-3.11/soc branch.
