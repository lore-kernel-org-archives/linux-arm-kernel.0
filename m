From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Aug 2014 11:24:49 -0600
Subject: [PATCH] ARM: tegra: add PCIe-related pins to the Jetson TK1 pinmux
 tables
In-Reply-To: <1408742308-18004-1-git-send-email-swarren@wwwdotorg.org>
References: <1408742308-18004-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <53FB7161.7040502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2014 03:18 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> This pinmux tables currently omit any configuration for PCIe clk_req,
> wake, and rst pins, which in turn causes intermittent failures in
> U-Boot's PCIe support. Import an updated version of the pinmux tables
> which rectifies this.
>
> (While I'm still hoping to remove the pinmux tables from DTs for
> Tegra124+ devices, while they're still here, they may as well be
> complete and correct).

I've applied this to Tegra's for-3.18/dt branch.
