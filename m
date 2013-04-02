From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Apr 2013 09:57:32 -0600
Subject: [PATCH 1/2] ARM: tegra: move <mach/powergate.h> to
 <linux/tegra-powergate.h>
In-Reply-To: <1364602790-10759-1-git-send-email-swarren@wwwdotorg.org>
References: <1364602790-10759-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <515AFFEC.1000609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 06:19 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This is required so that code such as Tegra's PCIe and clock drivers
> can still access this header file once Tegra is converted to
> multiplatform, and <mach/> no longer exists.

The series applied to Tegra's for-3.10/multiplatform branch.
