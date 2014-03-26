From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 26 Mar 2014 14:05:23 -0600
Subject: [PATCH 1/2] ARM: tegra: enable fhandle in tegra_defconfig
In-Reply-To: <1395800972-26483-1-git-send-email-acourbot@nvidia.com>
References: <1395800972-26483-1-git-send-email-acourbot@nvidia.com>
Message-ID: <53333303.70709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2014 08:29 PM, Alexandre Courbot wrote:
> CONFIG_FHANDLE is required by systemd >= 210 to spawn a serial TTY.

The series,
Acked-by: Stephen Warren <swarren@nvidia.com>

Patch 1/2,
Tested-by: Stephen Warren <swarren@nvidia.com>
(although not with the new systemd version that requires the change, but
rather for regressions in Ubuntu 12.04)
