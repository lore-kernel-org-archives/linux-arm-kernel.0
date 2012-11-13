From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Nov 2012 12:25:48 -0700
Subject: [PATCH] ARM: tegra: trimslice: enable SPI flash
In-Reply-To: <1352834633-1426-1-git-send-email-swarren@wwwdotorg.org>
References: <1352834633-1426-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50A29EBC.3050102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2012 12:23 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> TrimSlice contains a 1MiB SPI flash. Represent this in the device tree.

I've applied this to Tegra's for-3.8/dt branch.
