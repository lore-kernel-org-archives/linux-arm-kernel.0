From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Feb 2013 16:45:32 -0700
Subject: [PATCH 1/2] pinctrl: tegra: add clfvs function to Tegra114 support
In-Reply-To: <1360621513-18814-1-git-send-email-rklein@nvidia.com>
References: <1360621513-18814-1-git-send-email-rklein@nvidia.com>
Message-ID: <5119829C.20400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 03:25 PM, Rhyland Klein wrote:
> This patch adds the definition for the cldvfs function for Tegra114 pinctrl
> support. This is based on work by Pritesh Raithatha.

Sorry I forgot about this before, but
Documentation/devicetree/bindings/pinctrl/nvidia,tegra114-pinmux.txt
needs to be updated too.

Aside from that,

Reviewed-by: Stephen Warren <swarren@nvidia.com>
