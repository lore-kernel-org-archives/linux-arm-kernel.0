From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Oct 2012 14:16:18 -0600
Subject: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
In-Reply-To: <1350910413-23925-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1350910413-23925-1-git-send-email-maxime.ripard@free-electrons.com>
 <1350910413-23925-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5085A992.3070902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 06:53 AM, Maxime Ripard wrote:
> Allow the i2c-mux-gpio to be used by a device tree enabled device. The
> bindings are inspired by the one found in the i2c-mux-pinctrl driver.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
