From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 2 Apr 2016 12:36:48 +0200
Subject: [PATCH 2/3] sunxi: A20-OLinuXino-LIME2: Add usb-power-supply
In-Reply-To: <1458932647-24268-2-git-send-email-haas@computerlinguist.org>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
 <1458932647-24268-2-git-send-email-haas@computerlinguist.org>
Message-ID: <20160402103648.GI4227@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 25, 2016 at 08:04:06PM +0100, Michael Haas wrote:
> The A20-OLinuXino-LIME2 uses the AXP209 PMIC. This patch adds the
> corresponding usb-power-supply node to the DTS.
> If CONFIG_AXP20X_POWER is set, this patch enables the /sys/class/power_supply/
> diirectory.
> 
> Signed-off-by: Michael Haas <haas@computerlinguist.org>

Is there *any* reason to not use the AXP209 dtsi where it's already
defined?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160402/fe44389a/attachment-0001.sig>
