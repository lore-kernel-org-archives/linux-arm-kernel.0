From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 Apr 2014 14:53:00 -0600
Subject: [PATCH 1/3] ARM: tegra: remove UART5/UARTE from tegra124.dtsi
In-Reply-To: <1396383197-5979-1-git-send-email-swarren@wwwdotorg.org>
References: <1396383197-5979-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <534C4AAC.2020207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2014 02:13 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra124 only has 4 UARTs. Parts of the documentation hint at a fifth
> UART, but this appears to be left-over from earlier SoC documentation.
> Remove the non-existent DT node for UART5.

arm-soc maintainers, I'm hoping this will be applied as a fix for v3.15
through the arm-soc tree. Do you want me to send a pull request with the
series? Patch 2/3 does touch files in drivers/clk; are you waiting for
Mike's ack on it? It already has Peter's ack as Tegra clock driver
maintainer.

Thanks.
