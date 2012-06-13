From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Jun 2012 16:03:30 -0600
Subject: [PATCH] i2c: let the core register devices from devicetree
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <4FD90E32.5040309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2012 03:12 PM, Wolfram Sang wrote:
> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.

At least on Tegra this works fine,
Tested-by: Stephen Warren <swarren@wwwdotorg.org>
