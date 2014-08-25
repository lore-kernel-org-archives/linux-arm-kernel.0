From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Aug 2014 11:45:38 -0600
Subject: [PATCH 0/3] Introduce of_match_machine() helper
In-Reply-To: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <53FB7642.1000808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2014 05:01 PM, Tuomas Tynkkynen wrote:
> Some mach-specific drivers that don't require their own node in the device tree
> (for example drivers/soc/*, cpufreq, cpuidle etc.) want to match on the device
> tree root compatible property instead. Instead of open-coding (and forgetting
> to call of_node_put on the root node) everywhere, add a helper to the OF core.

Tuomas, I assume there will be a new version of this series to address 
the review comments? For now, I'm not intending on applying this.
