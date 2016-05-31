From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 May 2016 21:02:07 +0200
Subject: [PATCH resend v2 0/6] regulator: axp20x: Add support for AXP809
 PMIC
In-Reply-To: <1464711804-19256-1-git-send-email-wens@csie.org>
References: <1464711804-19256-1-git-send-email-wens@csie.org>
Message-ID: <20160531190207.GP4908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 12:23:18AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> These are the remaining patches of my AXP809 PMIC support series. The
> mfd parts and regulator fixes were merged in v4.7-rc1. What's left are
> the AXP809 regulator driver and dts changes.
> 
> Patch 1 adds AXP809 support to the axp20x regulator driver. This patch
> depends on patch 3, and patches already in regulator/topic/axp20x.
> 
> Patch 2 adds a dtsi file for AXP809.
> 
> Patch 3 enables AXP809 support on the A80 Optimus board.
> 
> Patch 4 enables AXP809 support on the Cubieboard 4.

Merged the last 3

> 
> Patch 5 disables the dummy regulators from sunxi-common-regulators.dtsi
> on the A80 Optimus board. These aren't used in the board DTS anymore.
> 
> Patch 6 disables the dummy regulators from sunxi-common-regulators.dtsi,
> on the Cubieboard4. These aren't used in the board DTS anymore.

And we should just remove the include on his one.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160531/a71a6c72/attachment.sig>
