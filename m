From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Sep 2013 14:06:12 -0600
Subject: [PATCH] ARM: tegra: enable CPU_FREQ_STAT_DETAILS
In-Reply-To: <1379096911-28353-1-git-send-email-swarren@wwwdotorg.org>
References: <1379096911-28353-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5238B634.7080003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 12:28 PM, Stephen Warren wrote:
> This enables various sysfs files that are useful when testing cpufreq.

I have squashed this patch into Tegra's for-3.13/defconfig branch.
