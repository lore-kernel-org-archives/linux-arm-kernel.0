From: ipaton0@gmail.com (Iain Paton)
Date: Sat, 26 Mar 2016 00:48:52 +0000
Subject: [linux-sunxi] [PATCH 2/3] sunxi: A20-OLinuXino-LIME2: Add
 usb-power-supply
In-Reply-To: <1458932647-24268-2-git-send-email-haas@computerlinguist.org>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
 <1458932647-24268-2-git-send-email-haas@computerlinguist.org>
Message-ID: <56F5DC74.50108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/03/16 19:04, Michael Haas wrote:
> The A20-OLinuXino-LIME2 uses the AXP209 PMIC. This patch adds the
> corresponding usb-power-supply node to the DTS.
> If CONFIG_AXP20X_POWER is set, this patch enables the /sys/class/power_supply/
> diirectory.
> 
> Signed-off-by: Michael Haas <haas@computerlinguist.org>

Acked-by: Iain Paton <ipaton0@gmail.com>
