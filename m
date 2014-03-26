From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 23:20:37 +0100
Subject: [PATCH 1/2] ARM: tegra: enable fhandle in tegra_defconfig
In-Reply-To: <53333303.70709@wwwdotorg.org>
References: <1395800972-26483-1-git-send-email-acourbot@nvidia.com>
 <53333303.70709@wwwdotorg.org>
Message-ID: <201403262320.37195.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 March 2014, Stephen Warren wrote:
> On 03/25/2014 08:29 PM, Alexandre Courbot wrote:
> > CONFIG_FHANDLE is required by systemd >= 210 to spawn a serial TTY.
> 
> The series,
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> Patch 1/2,
> Tested-by: Stephen Warren <swarren@nvidia.com>
> (although not with the new systemd version that requires the change, but
> rather for regressions in Ubuntu 12.04)
> 
> 

Applied both to next/boards, thanks!

	Arnd
