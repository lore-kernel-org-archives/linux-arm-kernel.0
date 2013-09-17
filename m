From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Sep 2013 14:05:41 -0600
Subject: [PATCH] ARM: tegra: add fuses as device randomness
In-Reply-To: <1379096828-27644-1-git-send-email-swarren@wwwdotorg.org>
References: <1379096828-27644-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5238B615.9050701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 12:27 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Various fuses on Tegra include information that's unique to an individual
> chip, or a subset of chips. Call add_device_randomness() with this data
> to perturb the initial state of the random pool.

I have applied this patch to Tegra's for-3.13/soc branch.
