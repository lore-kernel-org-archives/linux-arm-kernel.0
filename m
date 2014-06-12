From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Jun 2014 14:15:50 -0600
Subject: [PATCH 1/2] ARM: tegra: Add device tree nodes for flow controller
In-Reply-To: <1402487891-6493-1-git-send-email-thierry.reding@gmail.com>
References: <1402487891-6493-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <539A0A76.40604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2014 05:58 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> These nodes are required so that the flow controller driver can obtain
> the I/O memory region from device tree rather than hard-coding it.

I don't see a file in Documentation/devicetree/bindings that describes
these nodes...
