From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Mar 2013 11:40:06 -0600
Subject: [PATCH 1/3] ARM: tegra: moving the CPU power timer function to
 PMC driver
In-Reply-To: <1363163246-26368-1-git-send-email-josephl@nvidia.com>
References: <1363163246-26368-1-git-send-email-josephl@nvidia.com>
Message-ID: <5140B9F6.3060604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 02:27 AM, Joseph Lo wrote:
> The CPU power timer set up fucntion was related to PMC register. Now moving
> it to PMC driver. And it also help to clean up the PM related code later.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> This series was based on the patch set of suspending support.

So the series is based on the suspend series in terms of patch context,
but does it actually /depend/ on that series?

This series feels like cleanup to me, so I'd be tempted to apply it to
Tegra's for-3.10/cleanup branch, whereas I was planning on applying the
suspend series to its own for-3.10/suspend topic branch.

If that won't work, I guess I can apply this series on top of the
suspend series in the suspend topic branch.
