From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Mar 2014 14:55:41 -0700
Subject: [PATCH v2 1/6] ARM: dts: tegra: add PCIe interrupt mapping
 properties
In-Reply-To: <1394025951-32438-2-git-send-email-l.stach@pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <53179D5D.4070303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2014 06:25 AM, Lucas Stach wrote:
> Those are defined by the common PCI binding.

It sounds like there's no dependency between pathces 1/6 and 2/6, so I
should apply 1/6 to the Tegra tree, and Bjorn apply 2/6 to the PCI tree?
