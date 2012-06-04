From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Jun 2012 11:44:33 -0600
Subject: [PATCH 1/3] ARM: tegra: make .dts compilation depend on Tegra2
 support
In-Reply-To: <1337636690-28211-1-git-send-email-swarren@wwwdotorg.org>
References: <1337636690-28211-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <4FCCF401.1060502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2012 03:44 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Update Makefile.boot to compile *.dts when the appropriate Tegra SoC
> support is enabled, rather than requiring Kconfig to list each board
> individually. Remove CONFIG_MACH_VENTANA now that it has no use.

Applied for 3.6 (the series).
