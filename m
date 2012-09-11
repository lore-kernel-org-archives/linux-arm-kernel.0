From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 14:01:37 -0600
Subject: [PATCH 1/2] ARM: dt: tegra: harmony: configure power off
In-Reply-To: <1347385427-9676-1-git-send-email-swarren@wwwdotorg.org>
References: <1347385427-9676-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <504F98A1.9090302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 11:43 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Add DT property to tell the TPS6586x that it should provide the
> pm_power_off() implementation. This allows "shutdown" to work.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> --
> Harmony is a separate patch, since the Harmony regulator support went into
> a different branch to other boards' regulator support.

Applied to Tegra's for-3.7/board-removal branch (since that's where
regulators were added to DT on Harmony)
