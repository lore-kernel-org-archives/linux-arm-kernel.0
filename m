From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Jan 2013 10:18:46 -0700
Subject: [PATCH] ARM: tegra114: cpuidle: add ARM_CPUIDLE_WFI_STATE support
In-Reply-To: <1358761746-13118-1-git-send-email-josephl@nvidia.com>
References: <1358761746-13118-1-git-send-email-josephl@nvidia.com>
Message-ID: <50FD7876.4010306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 02:49 AM, Joseph Lo wrote:
> Adding the generic ARM_CPUIDLE_WFI_STATE support for Tegra114.

This of course depends on Hiroshi's Tegra114 patches, right; you should
explicitly point out any dependencies when posting patches.

The code changes look reasonable, but of course I'll hold off applying
it until the Tegra114 support is checked in.
